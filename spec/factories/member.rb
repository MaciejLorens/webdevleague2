require 'factory_girl'

FactoryGirl.define do
  factory :member, class: Member do
    points 50
  end
end
