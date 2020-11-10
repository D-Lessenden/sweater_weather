class UsersSerializer
  include FastJsonapi::ObjectSerializer

  attributes :email, :api_key

  # attributes :users do |data|
  #   binding.pry
  # end
  end
