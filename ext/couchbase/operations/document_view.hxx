/* -*- Mode: C++; tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*- */
/*
 *   Copyright 2020-2021 Couchbase, Inc.
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */

#pragma once

#include <tao/json.hpp>
#include <operations/design_document.hxx>
#include <utils/url_codec.hxx>
#include <error_context/view.hxx>

namespace couchbase::operations
{
struct document_view_response {
    struct meta_data {
        std::optional<std::uint64_t> total_rows{};
        std::optional<std::string> debug_info{};
    };

    struct row {
        std::optional<std::string> id;
        std::string key;
        std::string value;
    };

    struct problem {
        std::string code;
        std::string message;
    };

    error_context::view ctx;
    document_view_response::meta_data meta_data{};
    std::vector<document_view_response::row> rows{};
    std::optional<problem> error{};
};

struct document_view_request {
    using response_type = document_view_response;
    using encoded_request_type = io::http_request;
    using encoded_response_type = io::http_response;
    using error_context_type = error_context::view;

    static const inline service_type type = service_type::view;

    std::string client_context_id{ uuid::to_string(uuid::random()) };
    std::chrono::milliseconds timeout{ timeout_defaults::management_timeout };

    std::string bucket_name;
    std::string document_name;
    std::string view_name;
    design_document::name_space name_space;

    std::optional<std::uint64_t> limit;
    std::optional<std::uint64_t> skip;

    enum class scan_consistency {
        not_bounded,
        update_after,
        request_plus,
    };
    std::optional<scan_consistency> consistency;

    std::vector<std::string> keys;

    std::optional<std::string> key;
    std::optional<std::string> start_key;
    std::optional<std::string> end_key;
    std::optional<std::string> start_key_doc_id;
    std::optional<std::string> end_key_doc_id;
    std::optional<bool> inclusive_end;

    std::optional<bool> reduce;
    std::optional<bool> group;
    std::optional<std::uint32_t> group_level;
    bool debug{ false };

    enum class sort_order { ascending, descending };
    std::optional<sort_order> order;
    std::vector<std::string> query_string{};

    [[nodiscard]] std::error_code encode_to(encoded_request_type& encoded, http_context& /* context */)
    {
        if (debug) {
            query_string.emplace_back("debug=true");
        }
        if (limit) {
            query_string.emplace_back(fmt::format("limit={}", *limit));
        }
        if (skip) {
            query_string.emplace_back(fmt::format("skip={}", *skip));
        }
        if (consistency) {
            switch (*consistency) {
                case scan_consistency::not_bounded:
                    query_string.emplace_back("stale=ok");
                    break;
                case scan_consistency::update_after:
                    query_string.emplace_back("stale=update_after");
                    break;
                case scan_consistency::request_plus:
                    query_string.emplace_back("stale=false");
                    break;
            }
        }
        if (key) {
            query_string.emplace_back(fmt::format("key={}", utils::string_codec::form_encode(*key)));
        }
        if (start_key) {
            query_string.emplace_back(fmt::format("start_key={}", utils::string_codec::form_encode(*start_key)));
        }
        if (end_key) {
            query_string.emplace_back(fmt::format("end_key={}", utils::string_codec::form_encode(*end_key)));
        }
        if (start_key_doc_id) {
            query_string.emplace_back(fmt::format("start_key_doc_id={}", utils::string_codec::form_encode(*start_key_doc_id)));
        }
        if (end_key_doc_id) {
            query_string.emplace_back(fmt::format("end_key_doc_id={}", utils::string_codec::form_encode(*end_key_doc_id)));
        }
        if (inclusive_end) {
            query_string.emplace_back(fmt::format("inclusive_end={}", inclusive_end.value() ? "true" : "false"));
        }
        if (reduce) {
            query_string.emplace_back(fmt::format("reduce={}", reduce.value() ? "true" : "false"));
        }
        if (group) {
            query_string.emplace_back(fmt::format("group={}", group.value() ? "true" : "false"));
        }
        if (group_level) {
            query_string.emplace_back(fmt::format("group_level={}", *group_level));
        }
        if (order) {
            switch (*order) {
                case sort_order::descending:
                    query_string.emplace_back("descending=true");
                    break;
                case sort_order::ascending:
                    query_string.emplace_back("descending=false");
                    break;
            }
        }

        tao::json::value body = tao::json::empty_object;
        if (!keys.empty()) {
            tao::json::value keys_array = tao::json::empty_array;
            for (const auto& entry : keys) {
                keys_array.push_back(tao::json::from_string(entry));
            }
            body["keys"] = keys_array;
        }

        encoded.type = type;
        encoded.method = "POST";
        encoded.headers["content-type"] = "application/json";
        encoded.path = fmt::format("/{}/_design/{}{}/_view/{}?{}",
                                   bucket_name,
                                   name_space == design_document::name_space::development ? "dev_" : "",
                                   document_name,
                                   view_name,
                                   fmt::join(query_string, "&"));
        encoded.body = tao::json::to_string(body);
        return {};
    }
};

document_view_response
make_response(error_context::view&& ctx, const document_view_request& request, document_view_request::encoded_response_type&& encoded)
{
    document_view_response response{ std::move(ctx) };
    response.ctx.client_context_id = request.client_context_id;
    response.ctx.design_document_name = request.document_name;
    response.ctx.view_name = request.view_name;
    response.ctx.query_string = request.query_string;
    if (!response.ctx.ec) {
        if (encoded.status_code == 200) {
            tao::json::value payload{};
            try {
                payload = tao::json::from_string(encoded.body);
            } catch (const tao::pegtl::parse_error& e) {
                response.ctx.ec = error::common_errc::parsing_failure;
                return response;
            }

            if (const auto* total_rows = payload.find("total_rows"); total_rows != nullptr && total_rows->is_unsigned()) {
                response.meta_data.total_rows = total_rows->get_unsigned();
            }

            if (const auto* debug_info = payload.find("debug_info"); debug_info != nullptr && debug_info->is_object()) {
                response.meta_data.debug_info.emplace(tao::json::to_string(*debug_info));
            }

            if (const auto* rows = payload.find("rows"); rows != nullptr && rows->is_array()) {
                for (const auto& entry : rows->get_array()) {
                    document_view_response::row row{};

                    if (const auto* id = entry.find("id"); id != nullptr && id->is_string()) {
                        row.id = id->get_string();
                    }
                    row.key = tao::json::to_string(entry.at("key"));
                    row.value = tao::json::to_string(entry.at("value"));
                    response.rows.emplace_back(row);
                }
            }
        } else if (encoded.status_code == 400) {
            tao::json::value payload{};
            try {
                payload = tao::json::from_string(encoded.body);
            } catch (const tao::pegtl::parse_error& e) {
                response.ctx.ec = error::common_errc::parsing_failure;
                return response;
            }
            document_view_response::problem problem{};

            if (const auto* error = payload.find("error"); error != nullptr && error->is_string()) {
                problem.code = error->get_string();
            }

            if (const auto* reason = payload.find("reason"); reason != nullptr && reason->is_string()) {
                problem.message = reason->get_string();
            }
            response.error.emplace(problem);
            response.ctx.ec = error::common_errc::invalid_argument;
        } else if (encoded.status_code == 404) {
            response.ctx.ec = error::view_errc::design_document_not_found;
        } else {
            response.ctx.ec = error::common_errc::internal_server_failure;
        }
    }
    return response;
}

} // namespace couchbase::operations
