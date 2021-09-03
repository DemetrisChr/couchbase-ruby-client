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

#include <regex>

#include <tao/json.hpp>

#include <version.hxx>
#include <operations/bucket_settings.hxx>
#include <utils/url_codec.hxx>

namespace couchbase::operations
{

struct scope_drop_response {
    error_context::http ctx;
    std::uint64_t uid{ 0 };
};

struct scope_drop_request {
    using response_type = scope_drop_response;
    using encoded_request_type = io::http_request;
    using encoded_response_type = io::http_response;
    using error_context_type = error_context::http;

    static const inline service_type type = service_type::management;

    std::string bucket_name;
    std::string scope_name;
    std::chrono::milliseconds timeout{ timeout_defaults::management_timeout };
    std::string client_context_id{ uuid::to_string(uuid::random()) };

    [[nodiscard]] std::error_code encode_to(encoded_request_type& encoded, http_context& /* context */) const
    {
        encoded.method = "DELETE";
        encoded.path = fmt::format("/pools/default/buckets/{}/scopes/{}", bucket_name, scope_name);
        return {};
    }
};

scope_drop_response
make_response(error_context::http&& ctx, const scope_drop_request& /* request */, scope_drop_request::encoded_response_type&& encoded)
{
    scope_drop_response response{ std::move(ctx) };
    if (!response.ctx.ec) {
        switch (encoded.status_code) {
            case 400:
                response.ctx.ec = error::common_errc::unsupported_operation;
                break;
            case 404: {
                std::regex scope_not_found("Scope with name .+ is not found");
                if (std::regex_search(encoded.body, scope_not_found)) {
                    response.ctx.ec = error::common_errc::scope_not_found;
                } else {
                    response.ctx.ec = error::common_errc::bucket_not_found;
                }
            } break;
            case 200: {
                tao::json::value payload{};
                try {
                    payload = tao::json::from_string(encoded.body);
                } catch (const tao::pegtl::parse_error& e) {
                    response.ctx.ec = error::common_errc::parsing_failure;
                    return response;
                }
                response.uid = std::stoull(payload.at("uid").get_string(), 0, 16);
            } break;
            default:
                response.ctx.ec = error::common_errc::internal_server_failure;
                break;
        }
    }
    return response;
}

} // namespace couchbase::operations
