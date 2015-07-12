FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    password "goodomens"
  end
end