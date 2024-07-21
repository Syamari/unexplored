# spec/factories/lists.rb
FactoryBot.define do
  factory :list do
    sequence(:name) { |n| "Test List#{n}" }
    user
  end
end
