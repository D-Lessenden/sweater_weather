require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
    it {should validate_presence_of :password_confirmation}
    it {should validate_uniqueness_of :email}
  end

  it 'can create user' do
    user_params = {
                    email: 'whatever@example.com',
                    password: 'password',
                    password_confirmation: 'password'
                  }

    new_user = User.create(user_params)

    expect(new_user.email).to eq('whatever@example.com')
  end
end
