require 'rails_helper'
describe Munchie do
  it 'can create an object' do
    coords = MapFacade.return_coords('pueblo,co')
    route = MapService.route('puebloe,co', 'denver,co')
    forecast = ForecastFacade.return_forecast(coords)

    conn = Faraday.new(url: 'https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP-API']}"
    end
    response = conn.get("/v3/businesses/search?term=chinese&latitude=#{coords[0]}&longitude=#{coords[1]}&limit=1")
    json = JSON.parse(response.body, symbolize_names: true)

    restaurant_route = Munchie.new(forecast: forecast, restaurant: json, destination: route, city: 'Pueblo, CO')

    expect(restaurant_route.destination).to have_key(:route)
    expect(restaurant_route.forecast).to have_key(:current)
    expect(restaurant_route.restaurant).to have_key(:businesses)
    expect(restaurant_route.city).to eq("Pueblo, CO")

  end
end
