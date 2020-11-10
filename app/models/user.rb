class User < ApplicationRecord
  has_secure_password
  validates :email, :password_confirmation, presence: true
  validates_uniqueness_of :email
  has_secure_token :api_key
end
