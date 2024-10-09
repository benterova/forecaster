require "test_helper"
class ForecastFacadeTest < ActiveSupport::TestCase
  ZIP_CODE = "48116"
  test "forecast returns a valid forecast" do
    forecast = ForecastFacade.forecast ZIP_CODE
    assert_not_nil forecast.daily
  end

  test "forecast returns from cache" do
    Rails.cache.delete("forecast_#{ZIP_CODE}")
    forecast1 = ForecastFacade.forecast ZIP_CODE
    forecast2 = ForecastFacade.forecast ZIP_CODE
    assert_not forecast1.from_cache
    assert forecast2.from_cache
  end

  test "forecast fetches a new forecast if the cache is empty" do
    Rails.cache.delete("forecast_#{ZIP_CODE}")
    forecast = ForecastFacade.forecast ZIP_CODE
    assert_not forecast.from_cache
  end

  test "forecast stores the forecast in the cache" do
    Rails.cache.delete("forecast_#{ZIP_CODE}")
    forecast = ForecastFacade.forecast ZIP_CODE
    assert_not forecast.from_cache
  end
end
