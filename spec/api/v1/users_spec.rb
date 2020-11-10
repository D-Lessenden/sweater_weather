require 'rails_helper'

describe 'Creates a new user API' do
  it 'can post to create a new user ' do

    user_params = ({
                      email: 'whatever@example.com',
                      password: 'password',
                      password_confirmation: 'password'
                    })
      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      json = JSON.parse(response.body, symbolize_names: true)
      user = User.last
  end
end
