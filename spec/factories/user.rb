require 'factory_girl'

FactoryGirl.define do
  factory :user, class: User do
    nick 'mcksnk'
    email 'mckl@poczta.fm'
    password 'secret1234'
    league_id { create(:league).id }
  end
end
