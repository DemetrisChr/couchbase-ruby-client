# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: couchbase/internal/hooks.v1.proto

require 'google/protobuf'

require 'google/protobuf/any_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("couchbase/internal/hooks.v1.proto", :syntax => :proto3) do
    add_message "couchbase.internal.hooks.v1.CreateHooksContextRequest" do
      optional :id, :string, 1
    end
    add_message "couchbase.internal.hooks.v1.CreateHooksContextResponse" do
    end
    add_message "couchbase.internal.hooks.v1.DestroyHooksContextRequest" do
      optional :id, :string, 1
    end
    add_message "couchbase.internal.hooks.v1.DestroyHooksContextResponse" do
    end
    add_message "couchbase.internal.hooks.v1.ValueRef" do
      oneof :value do
        optional :request_field, :string, 1
        optional :counter_value, :string, 2
        optional :json_value, :bytes, 3
      end
    end
    add_message "couchbase.internal.hooks.v1.HookCondition" do
      optional :left, :message, 1, "couchbase.internal.hooks.v1.ValueRef"
      optional :op, :enum, 2, "couchbase.internal.hooks.v1.ComparisonOperator"
      optional :right, :message, 3, "couchbase.internal.hooks.v1.ValueRef"
    end
    add_message "couchbase.internal.hooks.v1.HookAction" do
      oneof :action do
        optional :if, :message, 1, "couchbase.internal.hooks.v1.HookAction.If"
        optional :counter, :message, 2, "couchbase.internal.hooks.v1.HookAction.Counter"
        optional :wait_on_barrier, :message, 3, "couchbase.internal.hooks.v1.HookAction.WaitOnBarrier"
        optional :signal_barrier, :message, 4, "couchbase.internal.hooks.v1.HookAction.SignalBarrier"
        optional :return_response, :message, 5, "couchbase.internal.hooks.v1.HookAction.ReturnResponse"
        optional :return_error, :message, 6, "couchbase.internal.hooks.v1.HookAction.ReturnError"
        optional :execute, :message, 7, "couchbase.internal.hooks.v1.HookAction.Execute"
      end
    end
    add_message "couchbase.internal.hooks.v1.HookAction.If" do
      repeated :cond, :message, 1, "couchbase.internal.hooks.v1.HookCondition"
      repeated :match, :message, 2, "couchbase.internal.hooks.v1.HookAction"
      repeated :no_match, :message, 3, "couchbase.internal.hooks.v1.HookAction"
    end
    add_message "couchbase.internal.hooks.v1.HookAction.Counter" do
      optional :counter_id, :string, 1
      optional :delta, :int64, 2
    end
    add_message "couchbase.internal.hooks.v1.HookAction.WaitOnBarrier" do
      optional :barrier_id, :string, 1
    end
    add_message "couchbase.internal.hooks.v1.HookAction.SignalBarrier" do
      optional :barrier_id, :string, 1
      optional :signal_all, :bool, 2
    end
    add_message "couchbase.internal.hooks.v1.HookAction.ReturnResponse" do
      optional :value, :message, 1, "google.protobuf.Any"
    end
    add_message "couchbase.internal.hooks.v1.HookAction.ReturnError" do
      optional :code, :int32, 1
      optional :message, :string, 2
      repeated :details, :message, 3, "google.protobuf.Any"
    end
    add_message "couchbase.internal.hooks.v1.HookAction.Execute" do
    end
    add_message "couchbase.internal.hooks.v1.Hook" do
      optional :name, :string, 1
      optional :description, :string, 2
      optional :target_method, :string, 3
      repeated :actions, :message, 4, "couchbase.internal.hooks.v1.HookAction"
    end
    add_message "couchbase.internal.hooks.v1.AddHooksRequest" do
      optional :hooks_context_id, :string, 1
      repeated :hooks, :message, 2, "couchbase.internal.hooks.v1.Hook"
    end
    add_message "couchbase.internal.hooks.v1.AddHooksResponse" do
    end
    add_message "couchbase.internal.hooks.v1.WatchBarrierRequest" do
      optional :hooks_context_id, :string, 1
      optional :barrier_id, :string, 2
    end
    add_message "couchbase.internal.hooks.v1.WatchBarrierResponse" do
      optional :wait_id, :string, 2
    end
    add_message "couchbase.internal.hooks.v1.SignalBarrierRequest" do
      optional :hooks_context_id, :string, 1
      optional :barrier_id, :string, 2
      proto3_optional :wait_id, :string, 3
    end
    add_message "couchbase.internal.hooks.v1.SignalBarrierResponse" do
    end
    add_enum "couchbase.internal.hooks.v1.ComparisonOperator" do
      value :EQUAL, 0
      value :NOT_EQUAL, 1
      value :GREATER_THAN, 2
      value :GREATER_THAN_OR_EQUAL, 3
      value :LESS_THAN, 4
      value :LESS_THAN_OR_EQUAL, 5
    end
  end
end

module Couchbase
  module StellarNebula
    module Generated
      module InternalHooks
        module V1
          CreateHooksContextRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.CreateHooksContextRequest").msgclass
          CreateHooksContextResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.CreateHooksContextResponse").msgclass
          DestroyHooksContextRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.DestroyHooksContextRequest").msgclass
          DestroyHooksContextResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.DestroyHooksContextResponse").msgclass
          ValueRef = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.ValueRef").msgclass
          HookCondition = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.HookCondition").msgclass
          HookAction = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.HookAction").msgclass
          HookAction::If = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.HookAction.If").msgclass
          HookAction::Counter = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.HookAction.Counter").msgclass
          HookAction::WaitOnBarrier = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.HookAction.WaitOnBarrier").msgclass
          HookAction::SignalBarrier = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.HookAction.SignalBarrier").msgclass
          HookAction::ReturnResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.HookAction.ReturnResponse").msgclass
          HookAction::ReturnError = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.HookAction.ReturnError").msgclass
          HookAction::Execute = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.HookAction.Execute").msgclass
          Hook = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.Hook").msgclass
          AddHooksRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.AddHooksRequest").msgclass
          AddHooksResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.AddHooksResponse").msgclass
          WatchBarrierRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.WatchBarrierRequest").msgclass
          WatchBarrierResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.WatchBarrierResponse").msgclass
          SignalBarrierRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.SignalBarrierRequest").msgclass
          SignalBarrierResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.SignalBarrierResponse").msgclass
          ComparisonOperator = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.internal.hooks.v1.ComparisonOperator").enummodule
        end
      end
    end
  end
end
