class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :encrypted_password
  validates_uniqueness_of :email

  has_many :leagues, through: :divisions
  has_many :skills, through: :divisions
  has_many :members
  has_many :divisions, through: :members

  def update_points(value)
    self.points += value
    if self.points >= 100
      User.transaction do
        if !self.league.is?('GrandMaster', 4)
          self.points -= 100
          self.league = self.league.next
        end
      end
    end

    if self.points < 0
      User.transaction do
        if self.league.is?('Bronze', 1)
          self.points = 0
        else
          self.points += 100
          self.league = self.league.previous
        end
      end
    end
  end
end
