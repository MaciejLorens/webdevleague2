class Division < ActiveRecord::Base
  belongs_to :league
  belongs_to :skill
  has_many :members
  has_many :users, through: :members

  scope :by_skill, lambda { |skill| joins(:skill).where('skills.name = ?', skill) }
  scope :by_league, lambda { |league| joins(:league).where('leagues.league = ?', league) }
  scope :by_rank, lambda { |rank| joins(:league).where('leagues.rank = ?', rank) }
end
