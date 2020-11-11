require 'rails_helper'

describe ForecastService do
  it 'can return forecast for a city by its coordinates' do
    coords = MapService.return_coords('denver,co')
    forecast = ForecastService.return_forecast(coords)
    expect(forecast).to be_a(Hash)
    expect(forecast).to have_key(:current)
    expect(forecast[:current]).to be_a(Hash)
    expect(forecast[:current]).to have_key(:dt)
    expect(forecast[:current]).to have_key(:sunrise)
    expect(forecast[:current]).to have_key(:sunset)
    expect(forecast[:current]).to have_key(:temp)
    expect(forecast[:current]).to have_key(:feels_like)
    expect(forecast[:current]).to have_key(:uvi)
    expect(forecast[:current]).to have_key(:humidity)
    expect(forecast[:current]).to have_key(:visibility)

    expect(forecast).to have_key(:daily)
    expect(forecast[:daily]).to be_a(Array)
    expect(forecast[:daily].first).to have_key(:dt)
    expect(forecast[:daily].first).to have_key(:sunrise)
    expect(forecast[:daily].first).to have_key(:sunset)
    expect(forecast[:daily].first[:temp]).to have_key(:max)
    expect(forecast[:daily].first[:temp]).to have_key(:min)
    expect(forecast[:daily].first[:weather].first).to have_key(:description)
    expect(forecast[:daily].first[:weather].first).to have_key(:icon)

    expect(forecast).to have_key(:hourly)
    expect(forecast[:hourly]).to be_a(Array)
    expect(forecast[:hourly].first).to have_key(:dt)
    expect(forecast[:hourly].first).to have_key(:temp)
    expect(forecast[:hourly].first).to have_key(:wind_speed)
    expect(forecast[:hourly].first).to have_key(:wind_deg)
    expect(forecast[:hourly].first[:weather].first).to have_key(:description)
    expect(forecast[:hourly].first[:weather].first).to have_key(:icon)
  end

  it 'can return weather at an eta' do
    time = MapService.time_of_arrival(6237)
    coords = MapService.return_coords('denver,co')
    forecast = ForecastService.weather_at_eta(coords, time)
    expect(forecast).to be_a(Hash)
    expect(forecast).to have_key(:temp)
    expect(forecast[:temp]).to be_a(Numeric)
    expect(forecast).to have_key(:weather)
    expect(forecast[:weather]).to be_a(Array)
    expect(forecast[:weather].first[:description]).to be_a(String)
  end
end
