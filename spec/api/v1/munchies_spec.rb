require 'rails_helper'

describe 'Yelp API returns info FE team needs' do
  it 'gives restaurant for selected location' do
    get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"
    expect(response).to be_successful
    restaurant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(restaurant[:id]).to eq(nil)
    expect(restaurant[:type]).to eq('munchie')

    expect(restaurant[:attributes]).to have_key(:restaurant)
    expect(restaurant[:attributes][:restaurant].keys.count).to eq(2)

    expect(restaurant[:attributes][:restaurant]).to have_key(:name)
    expect(restaurant[:attributes][:restaurant][:name]).to be_a(String)
    expect(restaurant[:attributes][:restaurant][:name]).to eq("China Lantern")

    expect(restaurant[:attributes][:restaurant]).to have_key(:address)
    expect(restaurant[:attributes][:restaurant][:address]).to be_a(String)
    expect(restaurant[:attributes][:restaurant][:address]).to eq("315 W 4th St Pueblo, CO 81003")

  end
end
