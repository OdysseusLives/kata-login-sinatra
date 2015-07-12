FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    password "Goodone1"
  end
end