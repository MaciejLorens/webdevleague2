require 'factory_girl'

FactoryGirl.define do
  factory :question, class: Question do
    content 'question content'
  end
end
