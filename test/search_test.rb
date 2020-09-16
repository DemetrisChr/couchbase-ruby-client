#    Copyright 2020 Couchbase, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

require_relative "test_helper"

module Couchbase
  class SearchTest < BaseTest
    def setup
      options = Cluster::ClusterOptions.new
      options.authenticate(TEST_USERNAME, TEST_PASSWORD)
      @cluster = Cluster.connect(TEST_CONNECTION_STRING, options)
      @bucket = @cluster.bucket(TEST_BUCKET)
      @collection = @bucket.default_collection
      @index_name = "idx-#{@bucket.name}-#{rand(0..100_000)}"
      index = Management::SearchIndex.new
      index.name = @index_name
      index.source_name = @bucket.name
      @cluster.search_indexes.upsert_index(index)
      sleep(0.1) until @cluster.search_indexes.get_stats["#{@bucket.name}:#{@index_name}:num_mutations_to_index"] == 0
    end

    def teardown
      @cluster.disconnect
    end

    def test_simple_search
      doc_id = uniq_id(:foo)
      res = @collection.insert(doc_id, {"name" => "Arthur"})
      mutation_state = MutationState.new(res.mutation_token)
      options = Cluster::SearchOptions.new
      options.consistent_with(mutation_state)
      options.limit = 100

      retries = 20
      loop do
        res = @cluster.search_query(@index_name, Cluster::SearchQuery.query_string("arthur"), options)
        next if res.meta_data.errors&.any? { |_, desc| desc.match?(/pindex( not available|_consistency mismatched partition)/) }

        if TEST_SERVER_VERSION.alice? && res.rows.empty?
          puts "TEST_SERVER_VERSION=#{TEST_SERVER_VERSION}. retrying upsert, because search results were empty, res=#{res.inspect}"
          res = @collection.insert(doc_id, {"name" => "Arthur"})
          mutation_state = MutationState.new(res.mutation_token)
          options.consistent_with(mutation_state)
          next
        end
        refute_empty res.rows, "expected non empty result, errors=#{res.meta_data.errors}"
        assert res.rows.find { |row| row.id == doc_id }, "result expected to include #{doc_id}"
        break
      rescue Error::IndexNotReady
        retries -= 1
        if retries.positive?
          sleep(0.5)
          retry
        end
      end
    end
  end
end
