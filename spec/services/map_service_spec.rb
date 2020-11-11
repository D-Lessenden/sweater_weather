require 'rails_helper'

describe 'Map Service' do
  it 'can convert a location in the form of a city an array of coords, first element being lat, second lon' do
    coords = MapService.return_coords('denver, co')
    expect(coords).to be_a(Array)
    expect(coords[0]).to eq(39.738453)
    expect(coords[1]).to eq(-104.984853)
  end

  it 'can return a route from point a to point b' do
   point_a = 'denver,co'
   point_b = 'pueblo,co'
   route = MapService.route(point_a, point_b)
   expect(route).to have_key(:route)
   expect(route[:route]).to have_key(:formattedTime)
   expect(route[:route][:formattedTime]).to eq("01:43:57")
   expect(route[:route]).to have_key(:time)
   expect(route[:route][:time]).to eq(6237)
 end

 it 'converts time to h and m' do
    time = "01:43:57"
    converted = MapService.convert_time(time)
    expect(converted).to eq("01 hours 43 minutes")
  end

  it 'can grab estimated time of arrival' do
    time = 6237
    eta = MapService.time_of_arrival(time)
    expect(eta).to eq((Time.now + 6237).beginning_of_hour.to_i)
  end
end
