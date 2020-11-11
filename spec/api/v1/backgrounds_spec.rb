require 'rails_helper'

describe 'Background API returns info FE team needs' do
  it 'gives background for selected location' do
    get '/api/v1/backgrounds?location=denver,co'
    expect(response).to be_successful
    background = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(background[:id]).to eq(nil)
    expect(background.keys.count).to eq(3)
    expect(background[:type]).to eq('backgrounds')

    expect(background[:attributes][:image]).to have_key(:image_url_raw)
    expect(background[:attributes][:image][:image_url_raw]).to be_a(String)
    expect(background[:attributes][:image][:image_url_raw]).to eq("https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE4MDg0NH0")

    expect(background[:attributes][:image]).to have_key(:image_url_full)
    expect(background[:attributes][:image][:image_url_full]).to be_a(String)
    expect(background[:attributes][:image][:image_url_full]).to eq("https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjE4MDg0NH0")

    expect(background[:attributes][:image]).to have_key(:image_url_regular)
    expect(background[:attributes][:image][:image_url_regular]).to be_a(String)
    expect(background[:attributes][:image][:image_url_regular]).to eq("https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjE4MDg0NH0")

    expect(background[:attributes][:image][:credit]).to have_key(:creator)
    expect(background[:attributes][:image][:credit][:creator]).to be_a(String)
    expect(background[:attributes][:image][:credit][:creator]).to eq("joshua_forbes")

    expect(background[:attributes][:image][:credit]).to have_key(:portfolio)
    expect(background[:attributes][:image][:credit][:portfolio]).to be_a(String)
    expect(background[:attributes][:image][:credit][:portfolio]).to eq("https://www.joshuaforbes.co.za")
  end
end
