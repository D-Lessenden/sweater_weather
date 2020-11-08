require 'rails_helper'
describe Forecast do
  it 'has functioning wind_direction' do
    expect(Forecast.wind_direction(348.76)).to eq('North')
    expect(Forecast.wind_direction(12)).to eq('North North-East')
    expect(Forecast.wind_direction(35)).to eq('North East')
    expect(Forecast.wind_direction(57)).to eq('East North-East')
    expect(Forecast.wind_direction(80)).to eq('East')
    expect(Forecast.wind_direction(103)).to eq('East South-East')
    expect(Forecast.wind_direction(124.5)).to eq('South East')
    expect(Forecast.wind_direction(150)).to eq('South South-East')
    expect(Forecast.wind_direction(170)).to eq('South')
    expect(Forecast.wind_direction(196)).to eq('South South-West')
    expect(Forecast.wind_direction(215)).to eq('South West')
    expect(Forecast.wind_direction(240)).to eq('West South-West')
    expect(Forecast.wind_direction(260)).to eq('West')
    expect(Forecast.wind_direction(282.2)).to eq('West North-West')
    expect(Forecast.wind_direction(305)).to eq('North West')
    expect(Forecast.wind_direction(348.75)).to eq('North North-West')
  end

  it 'can convert_time' do
    expect(Forecast.convert_time(1604772000)).to eq('2020-11-07 12:00:00 -0600')
  end

  it 'can convert_date' do
    expect(Forecast.convert_date(1604772000)).to eq('2020-11-07')
  end
end
