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
      expect(response).to be_successful
      user = User.last

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).not_to eq(nil)

      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to be_a(String)
      expect(json[:data][:type]).to eq("users")

      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:email)
      expect(json[:data][:attributes][:email]).to be_a(String)
      expect(json[:data][:attributes][:email]).to eq('whatever@example.com')

      expect(json[:data][:attributes]).to have_key(:api_key)
      expect(json[:data][:attributes][:api_key]).to be_a(String)

      expect(json[:data][:attributes]).not_to have_key(:password)

      expect(user.id).not_to eq(nil)
      expect(user.email).to eq('whatever@example.com')
      expect(user.api_key).not_to eq(nil)
  end

  it 'does not create a new user if passwords do not match' do
    user_params = ({
                      email: 'whatever@example.com',
                      password: 'drowssap',
                      password_confirmation: 'password'
                    })
      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).not_to be_successful
      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Passwords do not match")
  end

  # xit 'does not create a new user if email is taken' do
  #   user_params1 = ({
  #                     email: 'whatever@example.com',
  #                     password: 'password',
  #                     password_confirmation: 'password'
  #                   })
  #     headers = {'CONTENT_TYPE' => 'application/json'}
  #     post '/api/v1/users', headers: headers, params: JSON.generate(user_params1)
  #
  #
  #     user_params2 = ({
  #                       email: 'whatever@example.com',
  #                       password: 'diff_pass',
  #                       password_confirmation: 'diff_pass'
  #                     })
  #     headers = {'CONTENT_TYPE' => 'application/json'}
  #     post '/api/v1/users', headers: headers, params: JSON.generate(user_params2)
  #     json = JSON.parse(response.body, symbolize_names: true)
  #
  #
  #     expect(response).not_to be_successful
  #     expect(json).to have_key(:error)
  #     expect(json[:error]).to eq("Email is already registered")
  # end

    it 'does not create a new user if email is missing' do
      user_params = ({
                        password: 'password',
                        password_confirmation: 'password'
                      })
      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).not_to be_successful
      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Email is a required field")
    end

    it 'does not create a new user if password is missing' do
      user_params = ({
                        email: 'whatever@example.com',
                        password_confirmation: 'password'
                      })
      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).not_to be_successful
      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Password is a required field")
    end

    it 'does not create a new user if password is missing' do
      user_params = ({
                        email: 'whatever@example.com',
                        password: 'password'
                      })
      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).not_to be_successful
      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Password confirmation is a required field")
    end
end
