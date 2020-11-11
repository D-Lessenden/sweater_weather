require 'rails_helper'

describe RoadTrip do
  it 'can create an object' do
    start_city = "Denver, CO"
    end_city = "Pueblo, CO"
    coords = MapFacade.return_coords("Pueblo, CO")
    forecast = ForecastFacade.return_forecast(coords)
    route = MapFacade.route(start_city, end_city)
    road_trip = RoadTrip.new(forecast: forecast, start_city: start_city, end_city: end_city, route: route)

    expect(road_trip.forecast).to have_key(:current)
    expect(road_trip.forecast).to have_key(:hourly)
    expect(road_trip.start_city).to eq("Denver, CO")
    expect(road_trip.end_city).to eq("Pueblo, CO")
    expect(road_trip.route).to have_key(:route)
    expect(road_trip.route[:route]).to have_key(:formattedTime)
    expect(road_trip.route[:route][:formattedTime]).to eq("01:43:57")
    expect(road_trip.route[:route]).to have_key(:time)
    expect(road_trip.route[:route][:time]).to eq(6237)
  end
end
