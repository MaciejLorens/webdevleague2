require 'factory_girl'

FactoryGirl.define do
  factory :division, class: Division do
    league League.first
    skill Skill.first
  end
end
