require 'rails_helper'

describe 'Forecast API returns info FE team needs' do
  it 'gives forecast for selected location' do
    get "/api/v1/forecast?location=denver,co"
    expect(response).to be_successful
    weather = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(weather[:id]).to eq(nil)
    expect(weather[:type]).to eq('forecast')

    expect(weather[:attributes]).to have_key(:current_weather)
    expect(weather[:attributes][:current_weather].keys.count).to eq(10)

    expect(weather[:attributes][:current_weather]).to have_key(:datetime)
    expect(weather[:attributes][:current_weather][:datetime]).to be_a(String)

    expect(weather[:attributes][:current_weather]).to have_key(:sunrise)
    expect(weather[:attributes][:current_weather][:sunrise]).to be_a(String)

    expect(weather[:attributes][:current_weather]).to have_key(:sunset)
    expect(weather[:attributes][:current_weather][:sunset]).to be_a(String)

    expect(weather[:attributes][:current_weather]).to have_key(:temperature)
    expect(weather[:attributes][:current_weather][:temperature]).to be_a(Numeric)

    expect(weather[:attributes][:current_weather]).to have_key(:feels_like)
    expect(weather[:attributes][:current_weather][:feels_like]).to be_a(Numeric)

    expect(weather[:attributes][:current_weather]).to have_key(:humidity)
    expect(weather[:attributes][:current_weather][:humidity]).to be_a(Integer)

    expect(weather[:attributes][:current_weather]).to have_key(:uvi)
    expect(weather[:attributes][:current_weather][:uvi]).to be_a(Numeric)

    expect(weather[:attributes][:current_weather]).to have_key(:visibility)
    expect(weather[:attributes][:current_weather][:visibility]).to be_a(Integer)

    expect(weather[:attributes][:current_weather]).to have_key(:conditions)
    expect(weather[:attributes][:current_weather][:conditions]).to be_a(String)

    expect(weather[:attributes][:current_weather]).to have_key(:icon)
    expect(weather[:attributes][:current_weather][:icon]).to be_a(String)

    expect(weather[:attributes]).to have_key(:daily_weather)
    expect(weather[:attributes][:daily_weather].count).to eq(5)
    expect(weather[:attributes][:daily_weather].first.keys.count).to eq(7)

    expect(weather[:attributes][:daily_weather].first).to have_key(:datetime)
    expect(weather[:attributes][:daily_weather].first[:datetime]).to be_a(String)

    expect(weather[:attributes][:daily_weather].first).to have_key(:sunrise)
    expect(weather[:attributes][:daily_weather].first[:sunrise]).to be_a(String)

    expect(weather[:attributes][:daily_weather].first).to have_key(:sunset)
    expect(weather[:attributes][:daily_weather].first[:sunset]).to be_a(String)

    expect(weather[:attributes][:daily_weather].first).to have_key(:max_temp)
    expect(weather[:attributes][:daily_weather].first[:max_temp]).to be_a(Numeric)

    expect(weather[:attributes][:daily_weather].first).to have_key(:min_temp)
    expect(weather[:attributes][:daily_weather].first[:min_temp]).to be_a(Numeric)

    expect(weather[:attributes][:daily_weather].first).to have_key(:conditions)
    expect(weather[:attributes][:daily_weather].first[:conditions]).to be_a(String)

    expect(weather[:attributes][:daily_weather].first).to have_key(:icon)
    expect(weather[:attributes][:daily_weather].first[:icon]).to be_a(String)


    expect(weather[:attributes]).to have_key(:hourly_weather)
    expect(weather[:attributes][:hourly_weather].first.keys.count).to eq(6)
    expect(weather[:attributes][:hourly_weather].count).to eq(8)

    expect(weather[:attributes][:hourly_weather].first).to have_key(:datetime)
    expect(weather[:attributes][:hourly_weather].first[:datetime]).to be_a(String)

    expect(weather[:attributes][:hourly_weather].first).to have_key(:predicted_temp)
    expect(weather[:attributes][:hourly_weather].first[:predicted_temp]).to be_a(Numeric)

    expect(weather[:attributes][:hourly_weather].first).to have_key(:wind_speed)
    expect(weather[:attributes][:hourly_weather].first[:wind_speed]).to be_a(Numeric)

    expect(weather[:attributes][:hourly_weather].first).to have_key(:wind_direction)
    expect(weather[:attributes][:hourly_weather].first[:wind_direction]).to be_a(String)

    expect(weather[:attributes][:hourly_weather].first).to have_key(:conditions)
    expect(weather[:attributes][:hourly_weather].first[:conditions]).to be_a(String)

    expect(weather[:attributes][:hourly_weather].first).to have_key(:icon)
    expect(weather[:attributes][:hourly_weather].first[:icon]).to be_a(String)
  end
end
