require 'rails_helper'

describe 'Road Trip API returns info FE team needs' do
  it 'returns road trip info for location 1 to location 2' do
    road_trip_params = ({
                      origin: 'Denver, CO',
                      destination: 'Pueblo, CO',
                      api_key: "jgn983hy48thw9begh98h4539h4"
                      })

    headers = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)
    expect(response).to be_successful
    road_trip = JSON.parse(response.body, symbolize_names: true)

    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data][:id]).to eq(nil)

    expect(road_trip[:data]).to have_key(:type)
    expect(road_trip[:data][:type]).to eq('roadtrip')

    expect(road_trip[:data]).to have_key(:attributes)
    expect(road_trip[:data][:attributes].keys.count).to eq(4)

    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
    expect(road_trip[:data][:attributes][:travel_time]).to eq("01 hours 43 minutes")

    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
    expect(road_trip[:data][:attributes][:start_city]).to eq("Denver, CO")

    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
    expect(road_trip[:data][:attributes][:end_city]).to eq("Pueblo, CO")


    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
    expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)

    expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end
end
