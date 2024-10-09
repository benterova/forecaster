class ForecastController < ApplicationController
  # Default page for the app.
  # Includes search form for zip code.
  # GET /
  def index
  end

  # Displays the forecast for a given zip code
  # GET /forecast/:zip_code
  def show
    zip_code = forecast_params[:zip_code]
    @forecast_presenter = ForecastPresenter.new ForecastFacade.forecast(zip_code)
  rescue ForecastService::InvalidZipCodeError
    flash[:error] = "Invalid zip code: #{zip_code}"
    redirect_to root_path
  end

  private

  def forecast_params
    params.permit :zip_code
  end
end
