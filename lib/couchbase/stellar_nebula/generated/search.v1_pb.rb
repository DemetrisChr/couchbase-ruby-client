# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: couchbase/search.v1.proto

require 'google/protobuf'

require 'google/protobuf/duration_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("couchbase/search.v1.proto", :syntax => :proto3) do
    add_message "couchbase.search.v1.BooleanFieldQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :value, :bool, 6
    end
    add_message "couchbase.search.v1.BooleanQuery" do
      optional :boost, :float, 1
      optional :must, :message, 2, "couchbase.search.v1.Query"
      optional :must_not, :message, 3, "couchbase.search.v1.Query"
      optional :should, :message, 4, "couchbase.search.v1.Query"
      optional :should_min, :uint32, 5
    end
    add_message "couchbase.search.v1.ConjunctionQuery" do
      optional :boost, :float, 1
      repeated :queries, :message, 2, "couchbase.search.v1.Query"
    end
    add_message "couchbase.search.v1.DateRangeQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :date_time_parser, :string, 3
      optional :start_date, :string, 4
      optional :end_date, :string, 5
    end
    add_message "couchbase.search.v1.DisjunctionQuery" do
      optional :boost, :float, 1
      repeated :queries, :message, 2, "couchbase.search.v1.Query"
      optional :minimum, :uint32, 3
    end
    add_message "couchbase.search.v1.DocIdQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      repeated :ids, :string, 3
    end
    add_message "couchbase.search.v1.LatLng" do
      optional :latitude, :double, 1
      optional :longitude, :double, 2
    end
    add_message "couchbase.search.v1.GeoBoundingBoxQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :top_left, :message, 3, "couchbase.search.v1.LatLng"
      optional :bottom_right, :message, 4, "couchbase.search.v1.LatLng"
    end
    add_message "couchbase.search.v1.GeoDistanceQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :center, :message, 3, "couchbase.search.v1.LatLng"
      optional :distance, :string, 4
    end
    add_message "couchbase.search.v1.GeoPolygonQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      repeated :vertices, :message, 3, "couchbase.search.v1.LatLng"
    end
    add_message "couchbase.search.v1.MatchAllQuery" do
    end
    add_message "couchbase.search.v1.MatchNoneQuery" do
    end
    add_message "couchbase.search.v1.MatchPhraseQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :phrase, :string, 3
      optional :analyzer, :string, 4
    end
    add_message "couchbase.search.v1.MatchQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :value, :string, 3
      optional :analyzer, :string, 4
      optional :fuzziness, :uint64, 5
      optional :operator, :enum, 6, "couchbase.search.v1.MatchQuery.Operator"
      optional :prefix_length, :uint64, 7
    end
    add_enum "couchbase.search.v1.MatchQuery.Operator" do
      value :OR, 0
      value :AND, 1
    end
    add_message "couchbase.search.v1.NumericRangeQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :min, :float, 3
      optional :max, :float, 4
      optional :inclusive_min, :bool, 5
      optional :inclusive_max, :bool, 6
    end
    add_message "couchbase.search.v1.PhraseQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      repeated :terms, :string, 3
    end
    add_message "couchbase.search.v1.PrefixQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :prefix, :string, 3
    end
    add_message "couchbase.search.v1.QueryStringQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :query_string, :string, 3
    end
    add_message "couchbase.search.v1.RegexpQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :regexp, :string, 3
    end
    add_message "couchbase.search.v1.TermQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :term, :string, 3
      optional :fuzziness, :uint64, 4
      optional :prefix_length, :uint64, 5
    end
    add_message "couchbase.search.v1.TermRangeQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :term, :string, 3
      optional :fuzziness, :uint64, 4
      optional :min, :string, 5
      optional :max, :string, 6
      optional :inclusive_min, :bool, 7
      optional :inclusive_max, :bool, 8
    end
    add_message "couchbase.search.v1.WildcardQuery" do
      optional :boost, :float, 1
      optional :field, :string, 2
      optional :wildcard, :string, 3
    end
    add_message "couchbase.search.v1.Query" do
      oneof :query do
        optional :boolean_field_query, :message, 1, "couchbase.search.v1.BooleanFieldQuery"
        optional :boolean_query, :message, 2, "couchbase.search.v1.BooleanQuery"
        optional :conjunction_query, :message, 3, "couchbase.search.v1.ConjunctionQuery"
        optional :date_range_query, :message, 4, "couchbase.search.v1.DateRangeQuery"
        optional :disjunction_query, :message, 5, "couchbase.search.v1.DisjunctionQuery"
        optional :doc_id_query, :message, 6, "couchbase.search.v1.DocIdQuery"
        optional :geo_bounding_box_query, :message, 7, "couchbase.search.v1.GeoBoundingBoxQuery"
        optional :geo_distance_query, :message, 8, "couchbase.search.v1.GeoDistanceQuery"
        optional :geo_polygon_query, :message, 9, "couchbase.search.v1.GeoPolygonQuery"
        optional :match_all_query, :message, 10, "couchbase.search.v1.MatchAllQuery"
        optional :match_none_query, :message, 11, "couchbase.search.v1.MatchNoneQuery"
        optional :match_phrase_query, :message, 12, "couchbase.search.v1.MatchPhraseQuery"
        optional :match_query, :message, 13, "couchbase.search.v1.MatchQuery"
        optional :numeric_range_query, :message, 14, "couchbase.search.v1.NumericRangeQuery"
        optional :phrase_query, :message, 15, "couchbase.search.v1.PhraseQuery"
        optional :prefix_query, :message, 16, "couchbase.search.v1.PrefixQuery"
        optional :query_string_query, :message, 17, "couchbase.search.v1.QueryStringQuery"
        optional :regexp_query, :message, 18, "couchbase.search.v1.RegexpQuery"
        optional :term_query, :message, 19, "couchbase.search.v1.TermQuery"
        optional :term_range_query, :message, 20, "couchbase.search.v1.TermRangeQuery"
        optional :wildcard_query, :message, 21, "couchbase.search.v1.WildcardQuery"
      end
    end
    add_message "couchbase.search.v1.FieldSorting" do
      optional :field, :string, 1
      optional :descending, :bool, 2
      optional :missing, :string, 3
      optional :mode, :string, 4
      optional :type, :string, 5
    end
    add_message "couchbase.search.v1.GeoDistanceSorting" do
      optional :field, :string, 1
      optional :descending, :bool, 2
      optional :center, :message, 3, "couchbase.search.v1.LatLng"
      optional :unit, :string, 4
    end
    add_message "couchbase.search.v1.IdSorting" do
      optional :descending, :bool, 1
    end
    add_message "couchbase.search.v1.ScoreSorting" do
      optional :descending, :bool, 1
    end
    add_message "couchbase.search.v1.Sorting" do
      oneof :sorting do
        optional :field_sorting, :message, 1, "couchbase.search.v1.FieldSorting"
        optional :geo_distance_sorting, :message, 2, "couchbase.search.v1.GeoDistanceSorting"
        optional :id_sorting, :message, 3, "couchbase.search.v1.IdSorting"
        optional :score_sorting, :message, 4, "couchbase.search.v1.ScoreSorting"
      end
    end
    add_message "couchbase.search.v1.SearchQueryRequest" do
      optional :index_name, :string, 1
      optional :query, :message, 2, "couchbase.search.v1.Query"
      optional :scan_consistency, :enum, 3, "couchbase.search.v1.SearchQueryRequest.ScanConsistency"
      optional :limit, :uint32, 4
      optional :skip, :uint32, 5
      optional :include_explanation, :bool, 6
      optional :highlight_style, :enum, 7, "couchbase.search.v1.SearchQueryRequest.HighlightStyle"
      repeated :highlight_fields, :string, 8
      repeated :fields, :string, 9
      repeated :sort, :message, 10, "couchbase.search.v1.Sorting"
      optional :disable_scoring, :bool, 11
      repeated :collections, :string, 12
      optional :include_locations, :bool, 13
    end
    add_enum "couchbase.search.v1.SearchQueryRequest.ScanConsistency" do
      value :NOT_BOUNDED, 0
    end
    add_enum "couchbase.search.v1.SearchQueryRequest.HighlightStyle" do
      value :DEFAULT, 0
      value :HTML, 1
      value :ANSI, 2
    end
    add_message "couchbase.search.v1.SearchQueryResponse" do
      repeated :hits, :bytes, 1
      proto3_optional :meta_data, :message, 2, "couchbase.search.v1.SearchQueryResponse.MetaData"
    end
    add_message "couchbase.search.v1.SearchQueryResponse.MetaData" do
      optional :execution_time, :message, 1, "google.protobuf.Duration"
      optional :total_rows, :uint64, 2
      optional :max_score, :double, 3
      optional :total_partition_count, :uint64, 4
      optional :success_partition_count, :uint64, 5
      optional :error_partition_count, :uint64, 6
    end
  end
end

module Couchbase
  module StellarNebula
    module Generated
      module Search
        module V1
          BooleanFieldQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.BooleanFieldQuery").msgclass
          BooleanQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.BooleanQuery").msgclass
          ConjunctionQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.ConjunctionQuery").msgclass
          DateRangeQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.DateRangeQuery").msgclass
          DisjunctionQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.DisjunctionQuery").msgclass
          DocIdQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.DocIdQuery").msgclass
          LatLng = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.LatLng").msgclass
          GeoBoundingBoxQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.GeoBoundingBoxQuery").msgclass
          GeoDistanceQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.GeoDistanceQuery").msgclass
          GeoPolygonQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.GeoPolygonQuery").msgclass
          MatchAllQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.MatchAllQuery").msgclass
          MatchNoneQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.MatchNoneQuery").msgclass
          MatchPhraseQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.MatchPhraseQuery").msgclass
          MatchQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.MatchQuery").msgclass
          MatchQuery::Operator = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.MatchQuery.Operator").enummodule
          NumericRangeQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.NumericRangeQuery").msgclass
          PhraseQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.PhraseQuery").msgclass
          PrefixQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.PrefixQuery").msgclass
          QueryStringQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.QueryStringQuery").msgclass
          RegexpQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.RegexpQuery").msgclass
          TermQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.TermQuery").msgclass
          TermRangeQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.TermRangeQuery").msgclass
          WildcardQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.WildcardQuery").msgclass
          Query = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.Query").msgclass
          FieldSorting = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.FieldSorting").msgclass
          GeoDistanceSorting = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.GeoDistanceSorting").msgclass
          IdSorting = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.IdSorting").msgclass
          ScoreSorting = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.ScoreSorting").msgclass
          Sorting = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.Sorting").msgclass
          SearchQueryRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.SearchQueryRequest").msgclass
          SearchQueryRequest::ScanConsistency = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.SearchQueryRequest.ScanConsistency").enummodule
          SearchQueryRequest::HighlightStyle = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.SearchQueryRequest.HighlightStyle").enummodule
          SearchQueryResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.SearchQueryResponse").msgclass
          SearchQueryResponse::MetaData = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("couchbase.search.v1.SearchQueryResponse.MetaData").msgclass
        end
      end
    end
  end
end
