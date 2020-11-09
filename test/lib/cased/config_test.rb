# frozen_string_literal: true

require 'active_support/testing/assertions'

module Cased
  class ConfigTest < Cased::Test
    include ActiveSupport::Testing::Assertions

    def test_default_http_open_timeout
      config = Cased::Config.new

      assert_equal 5, config.http_open_timeout
    end

    def test_configure_http_open_timeout
      config = Cased::Config.new
      config.http_open_timeout = 10

      assert_equal 10, config.http_open_timeout
    end

    def test_configure_http_open_timeout_as_integer
      config = Cased::Config.new
      config.http_open_timeout = '15'

      assert_equal 15, config.http_open_timeout
    end

    def test_default_http_read_timeout
      config = Cased::Config.new

      assert_equal 10, config.http_read_timeout
    end

    def test_configure_http_read_timeout
      config = Cased::Config.new
      config.http_read_timeout = 5

      assert_equal 5, config.http_read_timeout
    end

    def test_configure_http_read_timeout_as_integer
      config = Cased::Config.new
      config.http_read_timeout = '15'

      assert_equal 15, config.http_read_timeout
    end

    def test_default_raise_on_errors
      config = Cased::Config.new

      refute_predicate config, :raise_on_errors?
    end

    def test_configure_raise_on_errors
      config = Cased::Config.new
      config.raise_on_errors = true

      assert_predicate config, :raise_on_errors?
    end

    def test_ensures_raise_on_errors_is_boolean
      config = Cased::Config.new
      config.raise_on_errors = '1'

      assert_equal true, config.raise_on_errors?
    end

    def test_default_api_url
      config = Cased::Config.new

      assert_equal 'https://api.cased.com', config.api_url
    end

    def test_configure_api_url
      config = Cased::Config.new
      config.api_url = 'https://api.staging.cased.com'

      assert_equal 'https://api.staging.cased.com', config.api_url
    end

    def test_configure_api_url_with_environment_variable
      original_api_url = ENV['CASED_API_URL']
      ENV['CASED_API_URL'] = 'https://api.staging.cased.com'
      config = Cased::Config.new

      assert_equal 'https://api.staging.cased.com', config.api_url
    ensure
      ENV['CASED_API_URL'] = original_api_url
    end

    def test_default_publish_url
      config = Cased::Config.new

      assert_equal 'https://publish.cased.com', config.publish_url
    end

    def test_configure_publish_url
      config = Cased::Config.new
      config.publish_url = 'https://publish.staging.cased.com'

      assert_equal 'https://publish.staging.cased.com', config.publish_url
    end

    def test_configure_publish_url_with_environment
      original_publish_url = ENV['CASED_PUBLISH_URL']
      ENV['CASED_PUBLISH_URL'] = 'https://publish.staging.cased.com'
      config = Cased::Config.new

      assert_equal 'https://publish.staging.cased.com', config.publish_url
    ensure
      ENV['CASED_PUBLISH_URL'] = original_publish_url
    end

    def test_default_publish_key
      config = Cased::Config.new

      assert_nil config.publish_key
    end

    def test_configure_publish_key
      config = Cased::Config.new
      config.publish_key = 'publish_live_1dQpY5JliYgHSkEntAbMVzuOROh'

      assert_equal 'publish_live_1dQpY5JliYgHSkEntAbMVzuOROh', config.publish_key
    end

    def test_configure_publish_key_with_environment
      original_publish_key = ENV['CASED_PUBLISH_KEY']
      ENV['CASED_PUBLISH_KEY'] = 'publish_live_1dQpY5JliYgHSkEntAbMVzuOROh'
      config = Cased::Config.new

      assert_equal 'publish_live_1dQpY5JliYgHSkEntAbMVzuOROh', config.publish_key
    ensure
      ENV['CASED_PUBLISH_KEY'] = original_publish_key
    end

    def test_configure_default_policy_key
      config = Cased::Config.new
      config.policy_key = 'policy_live_1dQpY5JliYgHSkEntAbMVzuOROh'

      assert_equal 'policy_live_1dQpY5JliYgHSkEntAbMVzuOROh', config.policy_key
    end

    def test_configure_default_policy_key_from_environment
      original_policy_key = ENV['CASED_POLICY_KEY']
      ENV['CASED_POLICY_KEY'] = 'policy_live_1dQpY5JliYgHSkEntAbMVzuOROh'
      config = Cased::Config.new

      assert_equal 'policy_live_1dQpY5JliYgHSkEntAbMVzuOROh', config.policy_key
    ensure
      ENV['CASED_POLICY_KEY'] = original_policy_key
    end

    def test_configure_additional_policy_key_from_environment
      original_organization_policy_key = ENV['CASED_ORGANIZATION_POLICY_KEY']
      ENV['CASED_ORGANIZATION_POLICY_KEY'] = 'policy_test_1dQpY5JliYgHSkEntAbMVzuOROh'
      config = Cased::Config.new

      assert_equal 'policy_test_1dQpY5JliYgHSkEntAbMVzuOROh', config.policy_key(:organization)
    ensure
      ENV['CASED_ORGANIZATION_POLICY_KEY'] = original_organization_policy_key
    end

    def test_fetching_unknown_environment_key
      config = Cased::Config.new

      assert_nil config.policy_key(:organization)
    end

    def test_lookup_unknown_environment_key_does_not_prevent_future_lookups
      config = Cased::Config.new

      assert_nil config.policy_key(:organization)

      original_organization_policy_key = ENV['CASED_ORGANIZATION_POLICY_KEY']
      ENV['CASED_ORGANIZATION_POLICY_KEY'] = 'policy_test_1dQpY5JliYgHSkEntAbMVzuOROh'

      assert_equal 'policy_test_1dQpY5JliYgHSkEntAbMVzuOROh', config.policy_key(:organization)
    ensure
      ENV['CASED_ORGANIZATION_POLICY_KEY'] = original_organization_policy_key
    end

    def test_configure_additional_policy_key
      config = Cased::Config.new
      config.policy_keys[:organization] = 'policy_test_1dQpY5JliYgHSkEntAbMVzuOROh'

      assert_equal 'policy_test_1dQpY5JliYgHSkEntAbMVzuOROh', config.policy_key(:organization)
    end

    def test_default_silence
      config = Cased::Config.new

      refute_predicate config, :silence?
    end

    def test_configure_silence
      config = Cased::Config.new
      config.silence = true

      assert_predicate config, :silence?
    end

    def test_configure_silence_with_environment
      original_silence = ENV['CASED_SILENCE']
      ENV['CASED_SILENCE'] = '1'
      config = Cased::Config.new

      assert_predicate config, :silence?
    ensure
      ENV['CASED_SILENCE'] = original_silence
    end
  end
end
