class User < ApplicationRecord
  has_secure_password
  validates :email, :password_confirmation, :api_key, presence: true
  validates_uniqueness_of :email
  has_secure_token :api_key
end
