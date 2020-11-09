class Api::V1::TrailsController < ApplicationController
  def show
    coords = MapFacade.return_coords(params[:location])
    binding.pry
    # render json: ForecastSerializer.new(ForecastFacade.return_forecast(coords))
  end
end
