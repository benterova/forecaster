module ForecastService
  module_function

  # Currently using v1 of the Open Meteo forecast & search API.
  # https://open-meteo.com/en/docs
  @forecast_url = Rails.application.credentials.open_meteo.forecast_url
  @geocoding_url = Rails.application.credentials.open_meteo.geocoding_url

  # Fetches the forecast for a given zip code.
  # Assumes that the zip code is valid.
  # @param zip_code [String] the zip code to fetch the forecast for.
  # @return [Hash] the forecast for the given zip code.
  def get_forecast(zip_code)
    latitude, longitude = get_lat_long zip_code
    params = {
      latitude:,
      longitude:,
      daily: [
        :apparent_temperature_min,
        :apparent_temperature_max,
        :precipitation_sum,
        :rain_sum
      ],
      current: :temperature_2m,
      timezone: "auto"
    }
    uri = URI(@forecast_url)

    uri.query = URI.encode_www_form params
    response = Net::HTTP.get_response uri

    raise InvalidZipCodeError if %w[400 404].include?(response.code)
    JSON.parse(response.body, symbolize_names: true)
  end

  # Fetches the latitude and longitude for a given zip code.
  # Assumes that the zip code or location name is valid,
  # and will return the first result from the Open Meteo API.
  # @param zip_code [String] the zip code to fetch the latitude and longitude for.
  # @return [Array] the latitude and longitude for the given zip code.
  def get_lat_long(zip_code)
    params = {
      name: zip_code
    }
    uri = URI(@geocoding_url)

    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)

    results = JSON.parse(response.body, symbolize_names: true)[:results]
    raise InvalidZipCodeError if %w[400 404].include?(response.code) || results.blank?
    forecast = results.first
    [forecast[:latitude], forecast[:longitude]]
  end

  # Raised when the zip code is not found in the Open Meteo API.
  class InvalidZipCodeError < StandardError; end
end
