ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Checks the forecast hash for the required keys
    def assert_forecast_keys(forecast)
      assert_includes forecast.keys, :latitude
      assert_includes forecast.keys, :longitude
      assert_includes forecast.keys, :daily
      assert_includes forecast[:daily].keys, :apparent_temperature_min
      assert_includes forecast[:daily].keys, :apparent_temperature_min
      assert_includes forecast[:daily].keys, :precipitation_sum
      assert_includes forecast[:daily].keys, :rain_sum
    end
  end
end
