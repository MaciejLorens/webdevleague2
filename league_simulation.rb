USER_COUNT = 2000
BATTLES = 200_000
WIN_POINTS = 20
LOSE_POINTS = 20

# user
class User
  attr_accessor :points, :wining_rate, :league, :rank
  def initialize(points, wining_rate, rank)
    @points = points
    @wining_rate = wining_rate
    @rank = rank
  end
end

def new_users
  # normal distribution
  def generate(average, deviation)
    sum = 0.0
    12.times{ sum += rand}
    ((sum - 6) * deviation) + average
  end

  # generate table of users
  users = []
  USER_COUNT.times do
    users << User.new(50, generate(0.5, 0.075), 1)
  end
  users
end

def print_results(users)
  result = {bronze: 0, silver: 0, gold: 0, platinum: 0, diamond: 0, master: 0, grand_master: 0, no: 0}
  users.each do |user|
    case user.rank
      when 0..3
        result[:bronze] += 1
      when 4..7
        result[:silver] += 1
      when 8..11
        result[:gold] += 1
      when 12..15
        result[:platinum] += 1
      when 16..19
        result[:diamond] += 1
      when 20..23
        result[:master] += 1
      when 24..27
        result[:grand_master] += 1
      else
        result[:no] += 1
    end
  end

  p "bronze = #{result[:bronze]} | #{result[:bronze].to_f / users.count * 100}"
  p "silver = #{result[:silver]} | #{result[:silver].to_f / users.count * 100}"
  p "gold = #{result[:gold]} | #{result[:gold].to_f / users.count * 100}"
  p "platinum = #{result[:platinum]} | #{result[:platinum].to_f / users.count * 100}"
  p "diamond = #{result[:diamond]} | #{result[:diamond].to_f / users.count * 100}"
  p "master = #{result[:master]} | #{result[:master].to_f / users.count * 100}"
  p "grand_master = #{result[:grand_master]} | #{result[:grand_master].to_f / users.count * 100}"
end

def random_users_to_fight(users)
  user1 = users[rand(users.count)]
  begin
    user2 = users[rand(users.count)]
  end while (user1.rank - user2.rank).abs > 4
  [user1, user2]
end

def game(users)
  # battle
  BATTLES.times do
    user1 , user2 = random_users_to_fight(users)
    next if user1 == user2

    bonus_points = case user1.rank
                     when 0..3
                       10
                     when 4..7
                       7
                     when 8..11
                       4
                     when 12..15
                       1
                     else
                       0
                   end

    wining_rate_delta = user1.wining_rate - user2.wining_rate
    if rand() + wining_rate_delta > 0.5
      user1.points += WIN_POINTS + bonus_points + 2 * (user2.rank - user1.rank)
      user2.points -= LOSE_POINTS - 4 * (user2.rank - user1.rank)
      user2.points = 0 if user2.points < 0
    else
      user2.points += WIN_POINTS + bonus_points + bonus_points + 2 * (user1.rank - user2.rank)
      user1.points -= LOSE_POINTS - 4 * (user1.rank - user2.rank)
      user1.points = 0 if user2.points < 0
    end

    user1.rank = user1.points / 100
    user2.rank = user2.points / 100
  end
end

BABY_BORD = 100
users = []
BABY_BORD.times do
  p "========================================="
  users = users + new_users()
  p "----------- users: #{users.count} ------------- "
  game(users)
  print_results(users)
  p "========================================="
end
