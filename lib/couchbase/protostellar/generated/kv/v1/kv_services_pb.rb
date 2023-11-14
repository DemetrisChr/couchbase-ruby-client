# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: couchbase/kv/v1/kv.proto for package 'Couchbase.Protostellar.Generated.KV.V1'

require 'grpc'
require 'couchbase/protostellar/generated/kv/v1/kv_pb'

module Couchbase
  module Protostellar
    module Generated
      module KV
        module V1
          module KvService
            class Service

              include ::GRPC::GenericService

              self.marshal_class_method = :encode
              self.unmarshal_class_method = :decode
              self.service_name = 'couchbase.kv.v1.KvService'

              rpc :Get, ::Couchbase::Protostellar::Generated::KV::V1::GetRequest, ::Couchbase::Protostellar::Generated::KV::V1::GetResponse
              rpc :GetAndTouch, ::Couchbase::Protostellar::Generated::KV::V1::GetAndTouchRequest, ::Couchbase::Protostellar::Generated::KV::V1::GetAndTouchResponse
              rpc :GetAndLock, ::Couchbase::Protostellar::Generated::KV::V1::GetAndLockRequest, ::Couchbase::Protostellar::Generated::KV::V1::GetAndLockResponse
              rpc :Unlock, ::Couchbase::Protostellar::Generated::KV::V1::UnlockRequest, ::Couchbase::Protostellar::Generated::KV::V1::UnlockResponse
              rpc :Touch, ::Couchbase::Protostellar::Generated::KV::V1::TouchRequest, ::Couchbase::Protostellar::Generated::KV::V1::TouchResponse
              rpc :Exists, ::Couchbase::Protostellar::Generated::KV::V1::ExistsRequest, ::Couchbase::Protostellar::Generated::KV::V1::ExistsResponse
              rpc :Insert, ::Couchbase::Protostellar::Generated::KV::V1::InsertRequest, ::Couchbase::Protostellar::Generated::KV::V1::InsertResponse
              rpc :Upsert, ::Couchbase::Protostellar::Generated::KV::V1::UpsertRequest, ::Couchbase::Protostellar::Generated::KV::V1::UpsertResponse
              rpc :Replace, ::Couchbase::Protostellar::Generated::KV::V1::ReplaceRequest, ::Couchbase::Protostellar::Generated::KV::V1::ReplaceResponse
              rpc :Remove, ::Couchbase::Protostellar::Generated::KV::V1::RemoveRequest, ::Couchbase::Protostellar::Generated::KV::V1::RemoveResponse
              rpc :Increment, ::Couchbase::Protostellar::Generated::KV::V1::IncrementRequest, ::Couchbase::Protostellar::Generated::KV::V1::IncrementResponse
              rpc :Decrement, ::Couchbase::Protostellar::Generated::KV::V1::DecrementRequest, ::Couchbase::Protostellar::Generated::KV::V1::DecrementResponse
              rpc :Append, ::Couchbase::Protostellar::Generated::KV::V1::AppendRequest, ::Couchbase::Protostellar::Generated::KV::V1::AppendResponse
              rpc :Prepend, ::Couchbase::Protostellar::Generated::KV::V1::PrependRequest, ::Couchbase::Protostellar::Generated::KV::V1::PrependResponse
              rpc :LookupIn, ::Couchbase::Protostellar::Generated::KV::V1::LookupInRequest, ::Couchbase::Protostellar::Generated::KV::V1::LookupInResponse
              rpc :MutateIn, ::Couchbase::Protostellar::Generated::KV::V1::MutateInRequest, ::Couchbase::Protostellar::Generated::KV::V1::MutateInResponse
              rpc :GetAllReplicas, ::Couchbase::Protostellar::Generated::KV::V1::GetAllReplicasRequest, stream(::Couchbase::Protostellar::Generated::KV::V1::GetAllReplicasResponse)
            end

            Stub = Service.rpc_stub_class
          end
        end
      end
    end
  end
end
