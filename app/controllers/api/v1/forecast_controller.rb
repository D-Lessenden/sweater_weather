class Api::V1::ForecastController < ApplicationController
  def show
    coords = MapFacade.return_coords(params[:location])
    render json: ForecastSerializer.new(ForecastFacade.return_forecast(coords))
  end
end
