require 'rails_helper'

describe 'User can login' do
  it 'returns user email and api_key when registered user logins' do
    user_params = ({
                      email: 'whatever@example.com',
                      password: 'password',
                      password_confirmation: 'password'
                    })
    headers = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    login = ({
              email: 'whatever@example.com',
              password: 'password'
            })

    headers = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/sessions', headers: headers, params: JSON.generate(login)
    session = JSON.parse(response.body, symbolize_names: :true)

    expect(response).to be_successful

    expect(session[:data]).to have_key(:id)
    expect(session[:data][:id]).not_to eq(nil)

    expect(session[:data]).to have_key(:type)
    expect(session[:data][:type]).to be_a(String)
    expect(session[:data][:type]).to eq("users")

    expect(session[:data]).to have_key(:attributes)
    expect(session[:data][:attributes]).to have_key(:email)
    expect(session[:data][:attributes][:email]).to be_a(String)
    expect(session[:data][:attributes][:email]).to eq('whatever@example.com')

    expect(session[:data][:attributes]).to have_key(:api_key)
    expect(session[:data][:attributes][:api_key]).to be_a(String)

    expect(session[:data][:attributes]).not_to have_key(:password)
  end

  it 'returns an error if email/password are incorrect' do
    user_params = ({
                      email: 'whatever@example.com',
                      password: 'password',
                      password_confirmation: 'password'
                    })
    headers = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    login = ({
              email: 'whatever@example.com',
              password: '123456'
            })

    headers = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/sessions', headers: headers, params: JSON.generate(login)
    session = JSON.parse(response.body, symbolize_names: :true)
    expect(response).not_to be_successful
    expect(session).to have_key(:error)
    expect(session[:error]).to eq("Incorrect credentials")
  end

  it 'returns an error if email is blank' do
    user_params = ({
                      email: 'whatever@example.com',
                      password: 'password',
                      password_confirmation: 'password'
                    })
    headers = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    login = ({
              password: 'password'
            })

    headers = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/sessions', headers: headers, params: JSON.generate(login)
    session = JSON.parse(response.body, symbolize_names: :true)
    expect(response).not_to be_successful
    expect(session).to have_key(:error)
    expect(session[:error]).to eq("Email is a require field")
  end

  it 'returns an error if password is blank' do
    user_params = ({
                      email: 'whatever@example.com',
                      password: 'password',
                      password_confirmation: 'password'
                    })
    headers = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    login = ({
              email: 'whatever@example.com'
            })

    headers = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/sessions', headers: headers, params: JSON.generate(login)
    session = JSON.parse(response.body, symbolize_names: :true)
    expect(response).not_to be_successful
    expect(session).to have_key(:error)
    expect(session[:error]).to eq("Password is a require field")
  end
end
