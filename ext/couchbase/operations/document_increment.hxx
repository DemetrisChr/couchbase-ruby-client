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

#include <protocol/cmd_increment.hxx>
#include <protocol/durability_level.hxx>
#include <operations.hxx>
#include <protocol/client_response.hxx>
#include <io/retry_context.hxx>

namespace couchbase::operations
{

struct increment_response {
    error_context::key_value ctx;
    std::uint64_t content{};
    std::uint64_t cas{};
    mutation_token token{};
};

struct increment_request {
    using encoded_request_type = protocol::client_request<protocol::increment_request_body>;
    using encoded_response_type = protocol::client_response<protocol::increment_response_body>;

    document_id id;
    std::uint16_t partition{};
    std::uint32_t opaque{};
    std::uint32_t expiry{ 0 };
    std::uint64_t delta{ 1 };
    std::optional<std::uint64_t> initial_value{};
    protocol::durability_level durability_level{ protocol::durability_level::none };
    std::optional<std::uint16_t> durability_timeout{};
    std::chrono::milliseconds timeout{ timeout_defaults::key_value_timeout };
    io::retry_context<io::retry_strategy::best_effort> retries{ false };
    bool preserve_expiry{ false };

    [[nodiscard]] std::error_code encode_to(encoded_request_type& encoded, mcbp_context&& /* context */) const
    {
        encoded.opaque(opaque);
        encoded.partition(partition);
        encoded.body().id(id);
        encoded.body().delta(delta);
        if (initial_value) {
            encoded.body().initial_value(initial_value.value());
            encoded.body().expiry(expiry);
        } else {
            encoded.body().initial_value(0);
            encoded.body().expiry(0xffff'ffff);
        }
        if (durability_level != protocol::durability_level::none) {
            encoded.body().durability(durability_level, durability_timeout);
        }
        if (preserve_expiry) {
            encoded.body().preserve_expiry();
        }
        return {};
    }
};

increment_response
make_response(error_context::key_value&& ctx, const increment_request& request, increment_request::encoded_response_type&& encoded)
{
    increment_response response{ std::move(ctx) };
    if (!response.ctx.ec) {
        response.cas = encoded.cas();
        response.content = encoded.body().content();
        response.token = encoded.body().token();
        response.token.partition_id = request.partition;
        response.token.bucket_name = response.ctx.id.bucket;
    }
    return response;
}

} // namespace couchbase::operations
