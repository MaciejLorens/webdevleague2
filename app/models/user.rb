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

  def update_points(skill_name, value)
    member = member_by_skill(skill_name)
    raise if member.nil?

    member.points += value
    if member.points >= 100
      User.transaction do
        unless member.league.is?('GrandMaster', 4)
          member.points -= 100
          member.league = member.league.next
        end
      end
    end

    if member.points < 0
      User.transaction do
        if member.league.is?('Bronze', 1)
          member.points = 0
        else
          member.points += 100
          member.league = member.league.previous
        end
      end
    end

    member.save
  end

  def member_by_skill(skill_name)
    self.members.joins(:division, :skill).where('skills.name = ?', skill_name).readonly(false).first
  end
end
