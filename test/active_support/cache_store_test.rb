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

require_relative "../test_helper"

require "active_support/notifications"
require "active_support/cache"

module Couchbase
  class CacheStoreTest < BaseTest
    def setup
      @cache = ActiveSupport::Cache.lookup_store(:couchbase_store, {
        connection_string: TEST_CONNECTION_STRING,
        username: TEST_USERNAME,
        password: TEST_PASSWORD,
        bucket: TEST_BUCKET,
      })
    end

    def test_clear
      foo = uniq_id(:foo)
      @cache.write(foo, "value_foo")
      @cache.clear
      assert_nil @cache.read(foo)
    end

    def test_write
      assert @cache.write("name", "value")
    end

    def test_read
      @cache.write("name", "value")
      assert_equal "value", @cache.read("name")
    end

    def test_delete
      @cache.write("name", "value")
      assert @cache.delete("name")
      refute @cache.delete("name")
    end

    def test_increment
      @cache.write("name", 1, raw: true)
      assert_equal 2, @cache.increment("name")
      name2 = uniq_id(:name2)
      assert_equal 0, @cache.increment(name2)
      assert_equal 3, @cache.increment(name2, 3)
      name3 = uniq_id(:name3)
      assert_equal 42, @cache.increment(name3, 2, initial: 42)
      assert_equal 44, @cache.increment(name3, 2, initial: 42)
    end

    def test_decrement
      @cache.write("name", 100, raw: true)
      assert_equal 99, @cache.decrement("name")
      name2 = uniq_id(:name2)
      assert_equal 0, @cache.decrement(name2)
      assert_equal 0, @cache.decrement(name2, 3)
      name3 = uniq_id(:name3)
      assert_equal 42, @cache.decrement(name3, 2, initial: 42)
      assert_equal 40, @cache.decrement(name3, 2, initial: 42)
    end

    def test_delete_matched
      foo = uniq_id(:foo)
      @cache.write(foo, "value_foo")
      bar = uniq_id(:bar)
      @cache.write(bar, "value_bar")
      @cache.delete_matched(/foo/)
      assert_nil @cache.read(foo)
      assert_equal "value_bar", @cache.read(bar)
    end

    def test_delete_multi
      foo = uniq_id(:foo)
      @cache.write(foo, "value_foo")
      bar = uniq_id(:bar)
      @cache.write(bar, "value_bar")
      @cache.delete_multi([foo, bar])
      assert_nil @cache.read(foo)
      assert_nil @cache.read(bar)
    end

    def test_read_multi
      foo = uniq_id(:foo)
      @cache.write(foo, "value_foo")
      bar = uniq_id(:bar)
      @cache.write(bar, "value_bar")
      results = @cache.read_multi(foo, bar)
      assert_equal 2, results.size
      assert_equal "value_foo", results[foo]
      assert_equal "value_bar", results[bar]
    end

    def test_write_multi
      foo = uniq_id(:foo)
      bar = uniq_id(:bar)
      success_count = @cache.write_multi(foo => "value_foo", bar => "value_bar")
      assert_equal 2, success_count
      assert_equal "value_foo", @cache.read(foo)
      assert_equal "value_bar", @cache.read(bar)
    end
  end
end
