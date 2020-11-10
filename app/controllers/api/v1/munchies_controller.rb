class Api::V1::MunchiesController < ApplicationController
  def show
    coords = MapFacade.return_coords(params[:end])
    route = MapService.route(params[:start], params[:end])
    forecast = ForecastFacade.return_forecast(coords)
    arrival = MapService.time_of_arrival(route[:route][:time])
    term = params[:term]

    conn = Faraday.new(url: 'https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP-API']}"
    end

    response = conn.get("/v3/businesses/search?term=#{params[:food]}&latitude=#{coords[0]}&longitude=#{coords[1]}&limit=1&open_at=#{arrival}")
    json = JSON.parse(response.body, symbolize_names: true)

    restaurant_route = Munchie.new(forecast: forecast, restaurant: json, destination: route, city: params[:end])

    render json: MunchiesSerializer.new(restaurant_route)
  end
end
