# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: couchbase/admin/collection.v1.proto for package 'Couchbase.StellarNebula.Generated.CollectionAdmin.V1'

require 'grpc'
require_relative 'collection.v1_pb'

module Couchbase
  module StellarNebula
    module Generated
      module CollectionAdmin
        module V1
          module CollectionAdmin
            class Service
              include ::GRPC::GenericService

              self.marshal_class_method = :encode
              self.unmarshal_class_method = :decode
              self.service_name = 'couchbase.admin.collection.v1.CollectionAdmin'

              rpc :ListCollections, ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::ListCollectionsRequest,
                  ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::ListCollectionsResponse
              rpc :CreateScope, ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::CreateScopeRequest, ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::CreateScopeResponse
              rpc :DeleteScope, ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::DeleteScopeRequest, ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::DeleteScopeResponse
              rpc :CreateCollection, ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::CreateCollectionRequest,
                  ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::CreateCollectionResponse
              rpc :DeleteCollection, ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::DeleteCollectionRequest,
                  ::Couchbase::StellarNebula::Generated::CollectionAdmin::V1::DeleteCollectionResponse
            end

            Stub = Service.rpc_stub_class
          end
        end
      end
    end
  end
end
