class ForecastPresenter
  # The ForecastPresenter class is responsible for formatting the forecast data
  # for display in the view. It takes a forecast result object and extracts the
  # relevant data for display.
  #
  # @param forecast_result [ForecastResult] the forecast result object
  def initialize(forecast_result)
    @forecast = forecast_result
  end

  def from_cache?
    @forecast.from_cache
  end

  def current_temperature
    @forecast.current_temperature
  end

  # Formats the forecast data for display in the view.
  def days
    @forecast.daily.map do |day|
      {
        date: Date.parse(day[:date]).strftime("%A, %B %d"),
        low: day[:apparent_temperature_min],
        high: day[:apparent_temperature_max],
        precipitation_sum: day[:precipitation_sum],
        rain_sum: day[:rain_sum],
        icon: (day[:rain_sum] > 0) ? "cloud-rain" : "sun"
      }
    end
  end
end
