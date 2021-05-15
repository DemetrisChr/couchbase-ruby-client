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

#include <protocol/unsigned_leb128.h>

#include <document_id.hxx>
#include <protocol/client_opcode.hxx>

namespace couchbase::protocol
{

class get_response_body
{
  public:
    static const inline client_opcode opcode = client_opcode::get;

  private:
    std::uint32_t flags_;
    std::string value_;

  public:
    [[nodiscard]] const std::string& value() const
    {
        return value_;
    }

    [[nodiscard]] std::uint32_t flags() const
    {
        return flags_;
    }

    bool parse(protocol::status status,
               const header_buffer& header,
               std::uint8_t framing_extras_size,
               std::uint16_t key_size,
               std::uint8_t extras_size,
               const std::vector<uint8_t>& body,
               const cmd_info& /* info */)
    {
        Expects(header[1] == static_cast<uint8_t>(opcode));
        if (status == protocol::status::success) {
            std::vector<uint8_t>::difference_type offset = framing_extras_size;
            if (extras_size == 4) {
                memcpy(&flags_, body.data() + offset, sizeof(flags_));
                flags_ = ntohl(flags_);
                offset += 4;
            } else {
                offset += extras_size;
            }
            offset += key_size;
            value_.assign(body.begin() + offset, body.end());
            return true;
        }
        return false;
    }
};

class get_request_body
{
  public:
    using response_body_type = get_response_body;
    static const inline client_opcode opcode = client_opcode::get;

  private:
    std::string key_;

  public:
    void id(const document_id& id)
    {
        key_ = id.key;
        if (id.collection_uid) {
            unsigned_leb128<uint32_t> encoded(*id.collection_uid);
            key_.insert(0, encoded.get());
        }
    }

    [[nodiscard]] const std::string& key() const
    {
        return key_;
    }

    [[nodiscard]] const std::vector<std::uint8_t>& framing_extras() const
    {
        return empty_buffer;
    }

    [[nodiscard]] const std::vector<std::uint8_t>& extras() const
    {
        return empty_buffer;
    }

    [[nodiscard]] const std::vector<std::uint8_t>& value() const
    {
        return empty_buffer;
    }

    [[nodiscard]] std::size_t size() const
    {
        return key_.size();
    }
};

} // namespace couchbase::protocol
