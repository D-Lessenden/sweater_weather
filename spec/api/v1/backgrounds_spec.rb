require 'rails_helper'

describe 'Background API returns info FE team needs' do
  it 'gives background for selected location' do
    get '/api/v1/backgrounds?location=denver,co'
    expect(response).to be_successful
    background = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(background.first[:id]).to eq(nil)
    expect(background.count).to eq(10)
    expect(background.first[:type]).to eq('backgrounds')

    expect(background.first[:attributes][:image]).to have_key(:image_url_raw)
    expect(background.first[:attributes][:image][:image_url_raw]).to be_a(String)

    expect(background.first[:attributes][:image]).to have_key(:image_url_full)
    expect(background.first[:attributes][:image][:image_url_full]).to be_a(String)

    expect(background.first[:attributes][:image]).to have_key(:image_url_regular)
    expect(background.first[:attributes][:image][:image_url_regular]).to be_a(String)

    expect(background.first[:attributes][:image]).to have_key(:image_url_small)
    expect(background.first[:attributes][:image][:image_url_small]).to be_a(String)

    expect(background.first[:attributes][:image]).to have_key(:image_url_thumb)
    expect(background.first[:attributes][:image][:image_url_thumb]).to be_a(String)

    expect(background.first[:attributes][:image]).to have_key(:creator)
    expect(background.first[:attributes][:image][:creator]).to be_a(String)

    expect(background.first[:attributes][:image]).to have_key(:portfolio)
    expect(background.first[:attributes][:image][:portfolio]).to be_a(String)
  end
end
