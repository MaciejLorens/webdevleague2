class League < ActiveRecord::Base
  validates_presence_of :league, :rank

  has_many :users

  scope :bronze, ->(rank) { where('league = "Bronze" AND rank = ?', rank).first }
  scope :silver, ->(rank) { where('league = "Silver" AND rank = ?', rank).first }
  scope :gold, ->(rank) { where('league = "Gold" AND rank = ?', rank).first }
  scope :platinum, ->(rank) { where('league = "Platinum" AND rank = ?', rank).first }
  scope :diamond, ->(rank) { where('league = "Diamond" AND rank = ?', rank).first }
  scope :master, ->(rank) { where('league = "Master" AND rank = ?', rank).first }
  scope :grand_master, ->(rank) { where('league = "GrandMaster" AND rank = ?', rank).first }

  RANK_MAX = 4
  ALL_LEAGUE = ['Bronze', 'Silver', 'Gold', 'Platinum', 'Diamond', 'Master', 'GrandMaster']

  def next
    if self.rank == RANK_MAX
      League.where('league = ? AND rank = ?', ALL_LEAGUE[ALL_LEAGUE.index(self.league) + 1], 1).first
    else
      League.where('league = ? AND rank = ?', self.league, self.rank + 1).first
    end
  end

  def previous
    if self.rank == 1
      League.where('league = ? AND rank = ?', ALL_LEAGUE[ALL_LEAGUE.index(self.league) - 1], 4).first
    else
      League.where('league = ? AND rank = ?', self.league, self.rank - 1).first
    end
  end

  def is?(league, rank)
    self.league == league && self.rank == rank
  end
end
