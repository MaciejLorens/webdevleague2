require 'factory_girl'

FactoryGirl.define do
  factory :skill, class: Skill do
    name 'skill_name'
  end

  factory :ruby_on_rails_skill, class: Skill do
    name 'Ruby on Rails'
  end

  factory :html5, class: Skill do
    name 'HTML5'
  end
end
