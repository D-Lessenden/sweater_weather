require 'rails_helper'

describe 'Trail API returns info about trails' do
  it 'gives forecast for selected location' do
    get '/api/v1/trails?location=denver,co'
    expect(response).to be_successful
    trails = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(trails[:id]).to eq(nil)
    expect(trails[:type]).to eq('trail')
    # binding.pry

    expect(trails[:attributes]).to have_key(:trails)
    expect(trails[:attributes][:trails]).to be_a(Array)

    expect(trails[:attributes][:trails].first).to have_key(:name)
    expect(trails[:attributes][:trails].first[:name]).to be_a(String)

    expect(trails[:attributes][:trails].first).to have_key(:summary)
    expect(trails[:attributes][:trails].first[:summary]).to be_a(String)

    expect(trails[:attributes][:trails].first).to have_key(:difficulty)
    expect(trails[:attributes][:trails].first[:difficulty]).to be_a(String)

    expect(trails[:attributes][:trails].first).to have_key(:location)
    expect(trails[:attributes][:trails].first[:location]).to be_a(String)

    # expect(trails[:attributes][:trails].first).to have_key(:distance_to_trail)


    # expect(trails[:attributes]).to have_key(:forecast)
      #has summary, temperature
      # each trail has name, summary, difficulty, distance_to_trail




  end
end
