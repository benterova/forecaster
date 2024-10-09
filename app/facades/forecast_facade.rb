module ForecastFacade
  module_function

  # Attempts to get the forecast from the cache. If it's not in the cache, it
  # fetches the forecast from the ForecastService and stores it in the cache.
  # @param zip_code [String] the zip code to get the forecast for
  # @return [ForecastResult] the forecast for the given zip code
  # @raise [ForecastService::InvalidZipCodeError] if the zip code is invalid
  def forecast(zip_code)
    from_cache = Rails.cache.exist?("forecast_#{zip_code}")
    cached_result = Rails.cache.fetch("forecast_#{zip_code}", expires_in: 30.minutes) do
      ForecastService.get_forecast zip_code
    end
    ForecastResult.new cached_result, from_cache
  end

  class ForecastResult
    attr_reader :latitude, :longitude, :daily, :current_temperature, :from_cache

    def initialize(forecast, from_cache = false)
      @latitude = forecast[:latitude]
      @longitude = forecast[:longitude]
      @current_temperature = forecast[:current][:temperature_2m]
      @daily = format_daily_forecast forecast[:daily]
      @from_cache = from_cache
    end

    private

    def format_daily_forecast(daily)
      # Format is structured like:
      # {:time=>[], :apparent_temperature_min=>[], :apparent_temperature_max=>[], :precipitation_sum=>[], :rain_sum=>[]}
      # Need to group it by index of each key to get the daily forecast
      daily[:time].map.with_index do |date, index|
        {
          date: date,
          apparent_temperature_min: daily[:apparent_temperature_min][index],
          apparent_temperature_max: daily[:apparent_temperature_max][index],
          precipitation_sum: daily[:precipitation_sum][index],
          rain_sum: daily[:rain_sum][index]
        }
      end
    end
  end
end
