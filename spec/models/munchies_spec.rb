require 'rails_helper'
describe Munchies do
  it 'can convert array to a string' do
    array = ["part1", "part2"]

    expect(Munchies.convert_array(array)).to eq('part1 part2')
  end
end
