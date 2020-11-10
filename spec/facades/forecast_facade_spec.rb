require 'rails_helper'

describe 'Forecast Facade' do
  it 'can expose a json with the weather for the selected city' do
    location = [39, 104]
    forecast = ForecastFacade.return_forecast(location)
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
    expect(forecast[:current][:weather].first).to have_key(:description)
    expect(forecast[:current][:weather].first).to have_key(:icon)


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
end
