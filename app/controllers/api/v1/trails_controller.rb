class Api::V1::TrailsController < ApplicationController
  def show
    coords = MapFacade.return_coords(params[:location])

    conn = Faraday.new('https://www.hikingproject.com')
    response = conn.get("/data/get-trails?lat=#{coords[0]}&lon=#{coords[1]}&maxDistance=30&key=#{ENV['HIKING-API']}")
    json = JSON.parse(response.body, symbolize_names: true)

    render json: TrailsSerializer.new(json)
  end
end
