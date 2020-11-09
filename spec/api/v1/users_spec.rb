require 'rails_helper'

describe 'Creates a new user API' do
  it 'can post to create a new user ' do
    body = {
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
              }


    conn = Faraday.new(url: 'https://api/v1')
    response = conn('/users').post do |request|
     request.body = body
    end

    binding.pry
    # post "/api/v1/users?#{params}"
    # expect(response).to be_successful

    json = JSON.parse(response.body)
      # post '/api/v1/users'
      # Content-Type: application/json
      # Accept: application/json
      #
      # {
      #   "email": "whatever@example.com",
      #   "password": "password"
      #   "password_confirmation": "password"
      # }

  end
end
