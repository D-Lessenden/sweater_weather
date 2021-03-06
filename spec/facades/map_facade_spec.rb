require 'rails_helper'

describe 'Map Facade' do
  it 'can convert a location in the form of a city an array of coords, first element being lat, second lon' do
    coords = MapFacade.return_coords('denver, co')
    expect(coords).to be_a(Array)
    expect(coords[0]).to eq(39.738453)
    expect(coords[1]).to eq(-104.984853)
  end

  it 'can return a route for two locations' do
    start = 'Denver, CO'
    finish = 'Pueblo, CO'
    route = MapFacade.route(start, finish)
    expect(route).to have_key(:route)
    expect(route[:route]).to have_key(:formattedTime)
    expect(route[:route][:formattedTime]).to eq("01:43:57")
    expect(route[:route]).to have_key(:time)
    expect(route[:route][:time]).to eq(6237)
  end
end
