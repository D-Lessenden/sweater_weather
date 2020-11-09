class Api::V1::TrailsController < ApplicationController
  def show
    coords = MapFacade.return_coords(params[:location])
    forecast = ForecastFacade.return_forecast(coords)

    conn = Faraday.new('https://www.hikingproject.com')
    response = conn.get("/data/get-trails?lat=#{coords[0]}&lon=#{coords[1]}&maxDistance=30&key=#{ENV['HIKING-API']}")
    json = JSON.parse(response.body, symbolize_names: true)
    trails_search = Trails.new(location: params[:location], forecast: forecast, trails: json)

    # render json: TrailsSerializer.new(TrailsFacade.return_trails(coords))
    render json: TrailsSerializer.new(trails_search)

  end
end
