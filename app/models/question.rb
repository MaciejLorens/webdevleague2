class Question < ActiveRecord::Base
  has_many :answers
  has_many :diagrams
  has_many :questions_users
  has_many :users, through: :questions_users
end
