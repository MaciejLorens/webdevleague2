require 'factory_girl'

FactoryGirl.define do
  factory :user, class: User do
    nick 'maciej'
    email 'mckl@poczta.fm'
    password 'secret1234'
  end
end
