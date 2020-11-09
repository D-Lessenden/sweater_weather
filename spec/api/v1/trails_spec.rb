require 'rails_helper'

describe 'Trail API returns info about trails' do
  it 'gives forecast for selected location' do
    get '/api/v1/trails?location=denver,co'
    expect(response).to be_successful
    # trails = JSON.parse(response.body, symbolize_names: true)[:data]

  end
end
