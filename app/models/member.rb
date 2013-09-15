class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :division
  has_one :league, through: :division
  has_one :skill, through: :division
end
