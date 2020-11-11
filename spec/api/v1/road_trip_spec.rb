require 'rails_helper'

describe 'Road Trip API returns info FE team needs' do
  it 'returns road trip info for location 1 to location 2' do
    user_params = ({
                      email: 'whatever@example.com',
                      password: 'password',
                      password_confirmation: 'password'
                    })

    headers = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
    user = JSON.parse(response.body, symbolize_names: true)

    road_trip_params = ({
                      origin: 'Denver, CO',
                      destination: 'Pueblo, CO',
                      api_key: user[:data][:attributes][:api_key]
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

  it 'sad path test for no api key' do
    road_trip_params = ({
                      origin: 'Denver, CO',
                      destination: 'Pueblo, CO',
                      api_key: 'fake api key'
                      })

    headers = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Unauthorized")
  end

  it 'sad path test for impossible routes' do
    user_params = ({
                      email: 'whatever@example.com',
                      password: 'password',
                      password_confirmation: 'password'
                    })

    headers = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
    user = JSON.parse(response.body, symbolize_names: true)

    road_trip_params = ({
                      origin: 'Denver, CO',
                      destination: 'London, UK',
                      api_key: user[:data][:attributes][:api_key]
                      })

    headers = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)
    road_trip = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data][:id]).to eq(nil)

    expect(road_trip[:data]).to have_key(:type)
    expect(road_trip[:data][:type]).to eq('roadtrip')

    expect(road_trip[:data]).to have_key(:attributes)
    expect(road_trip[:data][:attributes].keys.count).to eq(4)

    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
    expect(road_trip[:data][:attributes][:travel_time]).to eq("Impossible")

    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
    expect(road_trip[:data][:attributes][:start_city]).to eq("Denver, CO")
    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
    expect(road_trip[:data][:attributes][:end_city]).to eq("London, UK")

    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
    expect(road_trip[:data][:attributes][:weather_at_eta]).to eq(nil)
  end
end
