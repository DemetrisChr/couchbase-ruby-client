# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: couchbase/transactions/v1/transactions.proto

require 'google/protobuf'


descriptor_data = "\n,couchbase/transactions/v1/transactions.proto\x12\x19\x63ouchbase.transactions.v1\"e\n\x1eTransactionBeginAttemptRequest\x12\x13\n\x0b\x62ucket_name\x18\x01 \x01(\t\x12\x1b\n\x0etransaction_id\x18\x02 \x01(\tH\x00\x88\x01\x01\x42\x11\n\x0f_transaction_id\"M\n\x1fTransactionBeginAttemptResponse\x12\x16\n\x0etransaction_id\x18\x01 \x01(\t\x12\x12\n\nattempt_id\x18\x02 \x01(\t\"[\n\x18TransactionCommitRequest\x12\x13\n\x0b\x62ucket_name\x18\x01 \x01(\t\x12\x16\n\x0etransaction_id\x18\x02 \x01(\t\x12\x12\n\nattempt_id\x18\x03 \x01(\t\"\x1b\n\x19TransactionCommitResponse\"]\n\x1aTransactionRollbackRequest\x12\x13\n\x0b\x62ucket_name\x18\x01 \x01(\t\x12\x16\n\x0etransaction_id\x18\x02 \x01(\t\x12\x12\n\nattempt_id\x18\x03 \x01(\t\"\x1d\n\x1bTransactionRollbackResponse\"\x92\x01\n\x15TransactionGetRequest\x12\x13\n\x0b\x62ucket_name\x18\x01 \x01(\t\x12\x16\n\x0etransaction_id\x18\x02 \x01(\t\x12\x12\n\nattempt_id\x18\x03 \x01(\t\x12\x12\n\nscope_name\x18\x04 \x01(\t\x12\x17\n\x0f\x63ollection_name\x18\x05 \x01(\t\x12\x0b\n\x03key\x18\x06 \x01(\t\"4\n\x16TransactionGetResponse\x12\x0b\n\x03\x63\x61s\x18\x01 \x01(\x04\x12\r\n\x05value\x18\x02 \x01(\x0c\"\xa4\x01\n\x18TransactionInsertRequest\x12\x13\n\x0b\x62ucket_name\x18\x01 \x01(\t\x12\x16\n\x0etransaction_id\x18\x02 \x01(\t\x12\x12\n\nattempt_id\x18\x03 \x01(\t\x12\x12\n\nscope_name\x18\x04 \x01(\t\x12\x17\n\x0f\x63ollection_name\x18\x05 \x01(\t\x12\x0b\n\x03key\x18\x06 \x01(\t\x12\r\n\x05value\x18\x07 \x01(\x0c\"(\n\x19TransactionInsertResponse\x12\x0b\n\x03\x63\x61s\x18\x01 \x01(\x04\"\xb2\x01\n\x19TransactionReplaceRequest\x12\x13\n\x0b\x62ucket_name\x18\x01 \x01(\t\x12\x16\n\x0etransaction_id\x18\x02 \x01(\t\x12\x12\n\nattempt_id\x18\x03 \x01(\t\x12\x12\n\nscope_name\x18\x04 \x01(\t\x12\x17\n\x0f\x63ollection_name\x18\x05 \x01(\t\x12\x0b\n\x03key\x18\x06 \x01(\t\x12\x0b\n\x03\x63\x61s\x18\x07 \x01(\x04\x12\r\n\x05value\x18\x08 \x01(\x0c\")\n\x1aTransactionReplaceResponse\x12\x0b\n\x03\x63\x61s\x18\x01 \x01(\x04\"\xa2\x01\n\x18TransactionRemoveRequest\x12\x13\n\x0b\x62ucket_name\x18\x01 \x01(\t\x12\x16\n\x0etransaction_id\x18\x02 \x01(\t\x12\x12\n\nattempt_id\x18\x03 \x01(\t\x12\x12\n\nscope_name\x18\x04 \x01(\t\x12\x17\n\x0f\x63ollection_name\x18\x05 \x01(\t\x12\x0b\n\x03key\x18\x06 \x01(\t\x12\x0b\n\x03\x63\x61s\x18\x07 \x01(\x04\"(\n\x19TransactionRemoveResponse\x12\x0b\n\x03\x63\x61s\x18\x01 \x01(\x04\x32\xbb\x07\n\x13TransactionsService\x12\x92\x01\n\x17TransactionBeginAttempt\x12\x39.couchbase.transactions.v1.TransactionBeginAttemptRequest\x1a:.couchbase.transactions.v1.TransactionBeginAttemptResponse\"\x00\x12\x80\x01\n\x11TransactionCommit\x12\x33.couchbase.transactions.v1.TransactionCommitRequest\x1a\x34.couchbase.transactions.v1.TransactionCommitResponse\"\x00\x12\x86\x01\n\x13TransactionRollback\x12\x35.couchbase.transactions.v1.TransactionRollbackRequest\x1a\x36.couchbase.transactions.v1.TransactionRollbackResponse\"\x00\x12w\n\x0eTransactionGet\x12\x30.couchbase.transactions.v1.TransactionGetRequest\x1a\x31.couchbase.transactions.v1.TransactionGetResponse\"\x00\x12\x80\x01\n\x11TransactionInsert\x12\x33.couchbase.transactions.v1.TransactionInsertRequest\x1a\x34.couchbase.transactions.v1.TransactionInsertResponse\"\x00\x12\x83\x01\n\x12TransactionReplace\x12\x34.couchbase.transactions.v1.TransactionReplaceRequest\x1a\x35.couchbase.transactions.v1.TransactionReplaceResponse\"\x00\x12\x80\x01\n\x11TransactionRemove\x12\x33.couchbase.transactions.v1.TransactionRemoveRequest\x1a\x34.couchbase.transactions.v1.TransactionRemoveResponse\"\x00\x42\x96\x02\n1com.couchbase.client.protostellar.transactions.v1P\x01ZLgithub.com/couchbase/goprotostellar/genproto/transactions_v1;transactions_v1\xaa\x02&Couchbase.Protostellar.Transactions.V1\xca\x02\x30\x43ouchbase\\Protostellar\\Generated\\Transactions\\V1\xea\x02\x34\x43ouchbase::Protostellar::Generated::Transactions::V1b\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool

begin
  pool.add_serialized_file(descriptor_data)
rescue TypeError => e
  # Compatibility code: will be removed in the next major version.
  require 'google/protobuf/descriptor_pb'
  parsed = Google::Protobuf::FileDescriptorProto.decode(descriptor_data)
  parsed.clear_dependency
  serialized = parsed.class.encode(parsed)
  file = pool.add_serialized_file(serialized)
  warn "Warning: Protobuf detected an import path issue while loading generated file #{__FILE__}"
  imports = [
  ]
  imports.each do |type_name, expected_filename|
    import_file = pool.lookup(type_name).file_descriptor
    if import_file.name != expected_filename
      warn "- #{file.name} imports #{expected_filename}, but that import was loaded as #{import_file.name}"
    end
  end
  warn "Each proto file must use a consistent fully-qualified name."
  warn "This will become an error in the next major version."
end

module Couchbase
  module Protostellar
    module Generated
      module Transactions
        module V1
          TransactionBeginAttemptRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionBeginAttemptRequest").msgclass
          TransactionBeginAttemptResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionBeginAttemptResponse").msgclass
          TransactionCommitRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionCommitRequest").msgclass
          TransactionCommitResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionCommitResponse").msgclass
          TransactionRollbackRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionRollbackRequest").msgclass
          TransactionRollbackResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionRollbackResponse").msgclass
          TransactionGetRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionGetRequest").msgclass
          TransactionGetResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionGetResponse").msgclass
          TransactionInsertRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionInsertRequest").msgclass
          TransactionInsertResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionInsertResponse").msgclass
          TransactionReplaceRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionReplaceRequest").msgclass
          TransactionReplaceResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionReplaceResponse").msgclass
          TransactionRemoveRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionRemoveRequest").msgclass
          TransactionRemoveResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.transactions.v1.TransactionRemoveResponse").msgclass
        end
      end
    end
  end
end
