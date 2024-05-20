FactoryBot.define do
  factory :user do
    user_name { "Test User" }
    email { "test@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
