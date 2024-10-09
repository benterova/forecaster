require "test_helper"

class ForecastServiceTest < ActiveSupport::TestCase
  ZIP_CODE = "48116"
  BAD_ZIP_CODE = "badname"

  test "#get_forecast returns a valid forecast" do
    forecast = ForecastService.get_forecast ZIP_CODE
    assert_forecast_keys forecast
  end

  test "#get_forecast fails with an invalid zip code" do
    assert_raises ForecastService::InvalidZipCodeError do
      ForecastService.get_forecast BAD_ZIP_CODE
    end
  end
end
