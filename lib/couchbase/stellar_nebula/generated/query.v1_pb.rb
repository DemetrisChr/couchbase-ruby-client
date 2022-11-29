# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: couchbase/query.v1.proto

require 'google/protobuf'

require 'google/protobuf/duration_pb'
require_relative 'kv.v1_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("couchbase/query.v1.proto", :syntax => :proto3) do
    add_message "couchbase.query.v1.QueryRequest" do
      proto3_optional :bucket_name, :string, 1
      proto3_optional :scope_name, :string, 2
      optional :statement, :string, 3
      proto3_optional :read_only, :bool, 4
      proto3_optional :prepared, :bool, 5
      proto3_optional :tuning_options, :message, 6, "couchbase.query.v1.QueryRequest.TuningOptions"
      proto3_optional :client_context_id, :string, 7
      proto3_optional :scan_consistency, :enum, 8, "couchbase.query.v1.QueryRequest.QueryScanConsistency"
      repeated :positional_parameters, :bytes, 9
      map :named_parameters, :string, :bytes, 10
      proto3_optional :flex_index, :bool, 11
      proto3_optional :preserve_expiry, :bool, 12
      repeated :consistent_with, :message, 13, "couchbase.kv.v1.MutationToken"
      proto3_optional :profile_mode, :enum, 14, "couchbase.query.v1.QueryRequest.QueryProfileMode"
    end
    add_message "couchbase.query.v1.QueryRequest.TuningOptions" do
      proto3_optional :max_parallelism, :uint32, 1
      proto3_optional :pipeline_batch, :uint32, 2
      proto3_optional :pipeline_cap, :uint32, 3
      proto3_optional :scan_wait, :message, 4, "google.protobuf.Duration"
      proto3_optional :scan_cap, :uint32, 5
      proto3_optional :disable_metrics, :bool, 6
    end
    add_enum "couchbase.query.v1.QueryRequest.QueryScanConsistency" do
      value :NOT_BOUNDED, 0
      value :REQUEST_PLUS, 1
    end
    add_enum "couchbase.query.v1.QueryRequest.QueryProfileMode" do
      value :OFF, 0
      value :PHASES, 1
      value :TIMINGS, 2
    end
    add_message "couchbase.query.v1.QueryResponse" do
      repeated :rows, :bytes, 1
      proto3_optional :meta_data, :message, 2, "couchbase.query.v1.QueryResponse.MetaData"
    end
    add_message "couchbase.query.v1.QueryResponse.MetaData" do
      optional :request_id, :string, 1
      optional :client_context_id, :string, 2
      proto3_optional :metrics, :message, 3, "couchbase.query.v1.QueryResponse.MetaData.Metrics"
      optional :status, :enum, 4, "couchbase.query.v1.QueryResponse.MetaData.MetaDataStatus"
      repeated :warnings, :message, 5, "couchbase.query.v1.QueryResponse.MetaData.Warning"
      proto3_optional :profile, :bytes, 6
      optional :signature, :bytes, 7
    end
    add_message "couchbase.query.v1.QueryResponse.MetaData.Warning" do
      optional :code, :uint32, 1
      optional :message, :string, 2
    end
    add_message "couchbase.query.v1.QueryResponse.MetaData.Metrics" do
      optional :elapsed_time, :message, 1, "google.protobuf.Duration"
      optional :execution_time, :message, 2, "google.protobuf.Duration"
      optional :result_count, :uint64, 3
      optional :result_size, :uint64, 4
      optional :mutation_count, :uint64, 5
      optional :sort_count, :uint64, 6
      optional :error_count, :uint64, 7
      optional :warning_count, :uint64, 8
    end
    add_enum "couchbase.query.v1.QueryResponse.MetaData.MetaDataStatus" do
      value :RUNNING, 0
      value :SUCCESS, 1
      value :ERRORS, 2
      value :COMPLETED, 3
      value :STOPPED, 4
      value :TIMEOUT, 5
      value :CLOSED, 6
      value :FATAL, 7
      value :ABORTED, 8
      value :UNKNOWN, 9
    end
  end
end

module Couchbase
  module StellarNebula
    module Generated
      module Query
        module V1
          QueryRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.query.v1.QueryRequest").msgclass
          QueryRequest::TuningOptions = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.query.v1.QueryRequest.TuningOptions").msgclass
          QueryRequest::QueryScanConsistency = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.query.v1.QueryRequest.QueryScanConsistency").enummodule
          QueryRequest::QueryProfileMode = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.query.v1.QueryRequest.QueryProfileMode").enummodule
          QueryResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.query.v1.QueryResponse").msgclass
          QueryResponse::MetaData = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.query.v1.QueryResponse.MetaData").msgclass
          QueryResponse::MetaData::Warning = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.query.v1.QueryResponse.MetaData.Warning").msgclass
          QueryResponse::MetaData::Metrics = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.query.v1.QueryResponse.MetaData.Metrics").msgclass
          QueryResponse::MetaData::MetaDataStatus = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.query.v1.QueryResponse.MetaData.MetaDataStatus").enummodule
        end
      end
    end
  end
end
