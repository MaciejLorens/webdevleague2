require 'factory_girl'

FactoryGirl.define do
  factory :user, class: User do
    nick 'maciej'
    email { Faker::Internet.email }
    password 'secret1234'
  end
end
