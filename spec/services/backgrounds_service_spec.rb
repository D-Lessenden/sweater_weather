require 'rails_helper'

describe 'Backgrounds Service' do
  it 'can return photos depending on the provided location' do
    location = 'denver,co'
    background = BackgroundsService.return_background(location)
    expect(background).to be_a(Hash)
    expect(background).to have_key(:location)
    expect(background[:location]).to eq(location)
    expect(background).to have_key(:json)
    expect(background[:json][:results][0]).to have_key(:urls)
    expect(background[:json][:results][0][:urls]).to have_key(:raw)
    expect(background[:json][:results][0][:urls][:raw]).to eq("https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE4MDg0NH0")
    expect(background[:json][:results][0][:urls]).to have_key(:full)
    expect(background[:json][:results][0][:urls][:full]).to eq("https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjE4MDg0NH0")
    expect(background[:json][:results][0][:urls]).to have_key(:regular)
    expect(background[:json][:results][0][:urls][:regular]).to eq("https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjE4MDg0NH0")
  end
end
