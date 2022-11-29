# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: couchbase/internal/hooks.v1.proto for package 'Couchbase.StellarNebula.Generated.InternalHooks.V1'

require 'grpc'
require_relative 'hooks.v1_pb'

module Couchbase
  module StellarNebula
    module Generated
      module InternalHooks
        module V1
          module Hooks
            class Service
              include ::GRPC::GenericService

              self.marshal_class_method = :encode
              self.unmarshal_class_method = :decode
              self.service_name = 'couchbase.internal.hooks.v1.Hooks'

              rpc :CreateHooksContext, ::Couchbase::StellarNebula::Generated::InternalHooks::V1::CreateHooksContextRequest,
                  ::Couchbase::StellarNebula::Generated::InternalHooks::V1::CreateHooksContextResponse
              rpc :DestroyHooksContext, ::Couchbase::StellarNebula::Generated::InternalHooks::V1::DestroyHooksContextRequest,
                  ::Couchbase::StellarNebula::Generated::InternalHooks::V1::DestroyHooksContextResponse
              rpc :AddHooks, ::Couchbase::StellarNebula::Generated::InternalHooks::V1::AddHooksRequest, ::Couchbase::StellarNebula::Generated::InternalHooks::V1::AddHooksResponse
              rpc :WatchBarrier, ::Couchbase::StellarNebula::Generated::InternalHooks::V1::WatchBarrierRequest, stream(::Couchbase::StellarNebula::Generated::InternalHooks::V1::WatchBarrierResponse)
              rpc :SignalBarrier, ::Couchbase::StellarNebula::Generated::InternalHooks::V1::SignalBarrierRequest, ::Couchbase::StellarNebula::Generated::InternalHooks::V1::SignalBarrierResponse
            end

            Stub = Service.rpc_stub_class
          end
        end
      end
    end
  end
end
