class Skill < ActiveRecord::Base
  has_many :divisions
  has_many :leagues, through: :divisions
  has_many :users, through: :divisions
end
