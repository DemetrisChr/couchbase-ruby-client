# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: couchbase/query.v1.proto for package 'Couchbase.StellarNebula.Generated.Query.V1'

require 'grpc'
require_relative 'query.v1_pb'

module Couchbase
  module StellarNebula
    module Generated
      module Query
        module V1
          module Query
            class Service
              include ::GRPC::GenericService

              self.marshal_class_method = :encode
              self.unmarshal_class_method = :decode
              self.service_name = 'couchbase.query.v1.Query'

              rpc :Query, ::Couchbase::StellarNebula::Generated::Query::V1::QueryRequest, stream(::Couchbase::StellarNebula::Generated::Query::V1::QueryResponse)
            end

            Stub = Service.rpc_stub_class
          end
        end
      end
    end
  end
end
