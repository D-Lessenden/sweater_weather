class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      coords = MapFacade.return_coords(params[:destination])
      forecast = ForecastFacade.return_forecast(coords)
      route = MapFacade.route(params[:origin], params[:destination])
      road_trip = RoadTrip.new(forecast: forecast, start_city: params[:origin], end_city: params[:destination], route: route)
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
