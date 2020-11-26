FactoryBot.define do
  factory :user do
    email { Faker::FunnyName.name }
    password_digest { "MyString" }
    string { "MyString" }
    api_key { "MyString" }
  end
end
