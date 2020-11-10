require 'rails_helper'

describe 'Map Service' do
  it 'can convert a location in the form of a city an array of coords, first element being lat, second lon' do
    coords = MapService.return_coords('denver, co')
    expect(coords).to be_a(Array)
    expect(coords[0]).to eq(39.738453)
    expect(coords[1]).to eq(-104.984853)
  end
end
