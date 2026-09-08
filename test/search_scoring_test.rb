# frozen_string_literal: true

#  Copyright 2026-present Couchbase, Inc.
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

require "couchbase/protostellar/request_generator/search"

module Couchbase
  class SearchScoringTest < Minitest::Test
    include TestUtilities

    def setup
      # Do nothing
    end

    def teardown
      # Do nothing
    end

    def test_reciprocal_rank_fusion_without_parameters
      scoring = SearchScoring.reciprocal_rank_fusion

      assert_instance_of SearchScoring::SearchScoringReciprocalRankFusion, scoring
      assert_kind_of SearchScoring, scoring
      assert_equal({mode: :reciprocal_rank_fusion, params: {}}, scoring.to_backend)
    end

    def test_reciprocal_rank_fusion_with_parameters
      scoring = SearchScoring.reciprocal_rank_fusion do |s|
        s.rank_constant = 10
        s.window_size = 50
      end

      assert_equal 10, scoring.rank_constant
      assert_equal 50, scoring.window_size
      assert_equal({mode: :reciprocal_rank_fusion, params: {rank_constant: 10, window_size: 50}}, scoring.to_backend)
    end

    def test_reciprocal_rank_fusion_omits_unset_parameters
      scoring = SearchScoring.reciprocal_rank_fusion do |s|
        s.rank_constant = 10
      end

      assert_equal({mode: :reciprocal_rank_fusion, params: {rank_constant: 10}}, scoring.to_backend)

      scoring = SearchScoring.reciprocal_rank_fusion do |s|
        s.window_size = 50
      end

      assert_equal({mode: :reciprocal_rank_fusion, params: {window_size: 50}}, scoring.to_backend)
    end

    def test_reciprocal_rank_fusion_parameters_set_after_construction
      scoring = SearchScoring.reciprocal_rank_fusion
      scoring.rank_constant = 3
      scoring.window_size = 7

      assert_equal({mode: :reciprocal_rank_fusion, params: {rank_constant: 3, window_size: 7}}, scoring.to_backend)
    end

    def test_relative_score_fusion_without_parameters
      scoring = SearchScoring.relative_score_fusion

      assert_instance_of SearchScoring::SearchScoringRelativeScoreFusion, scoring
      assert_kind_of SearchScoring, scoring
      assert_equal({mode: :relative_score_fusion, params: {}}, scoring.to_backend)
    end

    def test_relative_score_fusion_with_parameters
      scoring = SearchScoring.relative_score_fusion do |s|
        s.window_size = 20
      end

      assert_equal 20, scoring.window_size
      assert_equal({mode: :relative_score_fusion, params: {window_size: 20}}, scoring.to_backend)
    end

    def test_scoring_none
      scoring = SearchScoring.none

      assert_instance_of SearchScoring::SearchScoringNone, scoring
      assert_kind_of SearchScoring, scoring
      assert_equal({mode: :none}, scoring.to_backend)
    end

    def test_search_options_without_scoring
      options = Options::Search.new(limit: 10)

      assert_nil options.scoring
      assert_nil options.to_backend[:scoring]
      refute options.to_backend[:disable_scoring]
    end

    def test_search_options_with_scoring
      options = Options::Search.new(
        limit: 10,
        scoring: SearchScoring.reciprocal_rank_fusion { |s| s.rank_constant = 60 },
      )

      assert_equal({mode: :reciprocal_rank_fusion, params: {rank_constant: 60}}, options.to_backend[:scoring])
      refute options.to_backend[:disable_scoring]
    end

    def test_search_options_with_scoring_set_after_construction
      options = Options::Search.new(limit: 10)
      options.scoring = SearchScoring.none

      assert_equal({mode: :none}, options.to_backend[:scoring])
    end

    def test_search_options_with_disable_scoring
      options = Options::Search.new(limit: 10, disable_scoring: true)

      assert options.to_backend[:disable_scoring]
      assert_nil options.to_backend[:scoring]
    end

    def test_search_options_with_both_disable_scoring_and_scoring
      options = Options::Search.new(limit: 10, disable_scoring: true, scoring: SearchScoring.none)

      assert_raises(Error::InvalidArgument) do
        options.to_backend
      end
    end

    def test_search_options_with_disable_scoring_set_after_construction
      options = Options::Search.new(limit: 10, scoring: SearchScoring.relative_score_fusion)
      options.disable_scoring = true

      assert_raises(Error::InvalidArgument) do
        options.to_backend
      end
    end

    def test_protostellar_without_scoring
      refute protostellar_request(Options::Search.new(limit: 10)).disable_scoring
    end

    def test_protostellar_with_disable_scoring
      assert protostellar_request(Options::Search.new(limit: 10, disable_scoring: true)).disable_scoring
    end

    def test_protostellar_with_scoring_none
      assert protostellar_request(Options::Search.new(limit: 10, scoring: SearchScoring.none)).disable_scoring
    end

    def test_protostellar_with_both_disable_scoring_and_scoring_none
      options = Options::Search.new(limit: 10, disable_scoring: true, scoring: SearchScoring.none)

      assert_raises(Error::InvalidArgument) do
        protostellar_request(options)
      end
    end

    def test_protostellar_with_fusion_scoring
      [SearchScoring.reciprocal_rank_fusion, SearchScoring.relative_score_fusion].each do |scoring|
        options = Options::Search.new(limit: 10, scoring: scoring)

        assert_raises(Error::FeatureNotAvailable) do
          protostellar_request(options)
        end
      end
    end

    def test_protostellar_with_both_disable_scoring_and_fusion_scoring
      options = Options::Search.new(limit: 10, disable_scoring: true, scoring: SearchScoring.reciprocal_rank_fusion)

      # The invalid combination of options must be reported regardless of whether the scoring mode is supported
      assert_raises(Error::InvalidArgument) do
        protostellar_request(options)
      end
    end

    private

    def protostellar_request(options)
      generator = Protostellar::RequestGenerator::Search.new
      generator.search_query_request("index", Cluster::SearchQuery.match_all, options).proto_request
    end
  end
end
