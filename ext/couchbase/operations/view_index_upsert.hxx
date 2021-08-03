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

namespace couchbase::operations
{
struct view_index_upsert_response {
    error_context::http ctx;
};

struct view_index_upsert_request {
    using response_type = view_index_upsert_response;
    using encoded_request_type = io::http_request;
    using encoded_response_type = io::http_response;
    using error_context_type = error_context::http;

    static const inline service_type type = service_type::view;

    std::string client_context_id{ uuid::to_string(uuid::random()) };
    std::chrono::milliseconds timeout{ timeout_defaults::management_timeout };

    std::string bucket_name;
    design_document document;

    [[nodiscard]] std::error_code encode_to(encoded_request_type& encoded, http_context& /* context */) const
    {
        tao::json::value body;
        body["views"] = tao::json::empty_object;
        for (const auto& view : document.views) {
            tao::json::value view_def;
            if (view.second.map) {
                view_def["map"] = *view.second.map;
            }
            if (view.second.reduce) {
                view_def["reduce"] = *view.second.reduce;
            }
            body["views"][view.first] = view_def;
        }

        encoded.headers["content-type"] = "application/json";
        encoded.method = "PUT";
        encoded.path = fmt::format(
          "/{}/_design/{}{}", bucket_name, document.ns == design_document::name_space::development ? "dev_" : "", document.name);
        encoded.body = tao::json::to_string(body);
        return {};
    }
};

view_index_upsert_response
make_response(error_context::http&& ctx,
              const view_index_upsert_request& /* request */,
              view_index_upsert_request::encoded_response_type&& encoded)
{
    view_index_upsert_response response{ std::move(ctx) };
    if (!response.ctx.ec) {
        switch (encoded.status_code) {
            case 200:
            case 201:
                break;
            case 400:
                response.ctx.ec = error::common_errc::invalid_argument;
                break;
            case 404:
                response.ctx.ec = error::view_errc::design_document_not_found;
                break;
            default:
                response.ctx.ec = error::common_errc::internal_server_failure;
        }
    }
    return response;
}

} // namespace couchbase::operations
