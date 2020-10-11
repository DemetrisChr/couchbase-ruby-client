/* -*- Mode: C++; tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*- */
/*
 *     Copyright 2020 Couchbase, Inc.
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

#include <version.hxx>

namespace couchbase::operations
{
struct search_index_control_ingest_response {
    std::string client_context_id;
    std::error_code ec;
    std::string status{};
    std::string error{};
};

struct search_index_control_ingest_request {
    using response_type = search_index_control_ingest_response;
    using encoded_request_type = io::http_request;
    using encoded_response_type = io::http_response;

    static const inline service_type type = service_type::search;

    std::string client_context_id{ uuid::to_string(uuid::random()) };
    std::chrono::milliseconds timeout{ timeout_defaults::management_timeout };

    std::string index_name;
    bool pause;

    [[nodiscard]] std::error_code encode_to(encoded_request_type& encoded, http_context&)
    {
        encoded.method = "POST";
        encoded.path = fmt::format("/api/index/{}/ingestControl/{}", index_name, pause ? "pause" : "resume");
        return {};
    }
};

search_index_control_ingest_response
make_response(std::error_code ec,
              search_index_control_ingest_request& request,
              search_index_control_ingest_request::encoded_response_type&& encoded)
{
    search_index_control_ingest_response response{ request.client_context_id, ec };
    if (!ec) {
        if (encoded.status_code == 200) {
            auto payload = tao::json::from_string(encoded.body);
            response.status = payload.at("status").get_string();
            if (response.status == "ok") {
                return response;
            }
        } else if (encoded.status_code == 400) {
            auto payload = tao::json::from_string(encoded.body);
            response.status = payload.at("status").get_string();
            response.error = payload.at("error").get_string();
            if (response.error.find("index not found") != std::string::npos) {
                response.ec = std::make_error_code(error::common_errc::index_not_found);
                return response;
            }
        }
        response.ec = std::make_error_code(error::common_errc::internal_server_failure);
    }
    return response;
}

} // namespace couchbase::operations
