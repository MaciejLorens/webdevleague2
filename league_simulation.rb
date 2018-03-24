USER_COUNT = 10000
WIN_POINTS = 12
LOSE_POINTS = 12

# user
class UserSimulation
  attr_accessor :points, :wining_rate, :league, :rank, :battles_count

  def initialize(points, wining_rate, rank)
    @points = points
    @wining_rate = wining_rate
    @rank = rank
    @battles_count = 0
  end
end

def new_users
  # normal distribution
  def generate(average, deviation)
    sum = 0.0
    12.times { sum += rand }
    ((sum - 6) * deviation) + average
  end

  # generate table of users
  users = []
  USER_COUNT.times do
    users << UserSimulation.new(100, generate(0.5, 0.15), 0)
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

  result[:average_battles] = users.map(&:battles_count).inject(0, :+) / users.count

  p "bronze = #{result[:bronze]} | #{result[:bronze].to_f / users.count * 100}"
  p "silver = #{result[:silver]} | #{result[:silver].to_f / users.count * 100}"
  p "gold = #{result[:gold]} | #{result[:gold].to_f / users.count * 100}"
  p "platinum = #{result[:platinum]} | #{result[:platinum].to_f / users.count * 100}"
  p "diamond = #{result[:diamond]} | #{result[:diamond].to_f / users.count * 100}"
  p "master = #{result[:master]} | #{result[:master].to_f / users.count * 100}"
  p "grand_master = #{result[:grand_master]} | #{result[:grand_master].to_f / users.count * 100}"
  p "average_battles = #{result[:average_battles]}"
  p "months to play = #{result[:average_battles].to_f / 2 / 30}"
end

def random_users_to_fight(users)
  user1 = users[rand(users.count)]
  begin
    user2 = users[rand(users.count)]
  end while (user1.rank - user2.rank).abs > 4
  [user1, user2]
end

def game(users)
  # signle battle
  user1, user2 = random_users_to_fight(users)
  return if user1 == user2

  user1.battles_count += 1
  user2.battles_count += 1

  bonus_points = case user1.rank
                   when 0..3
                     10
                   when 4..7
                     8
                   when 8..11
                     6
                   when 12..15
                     4
                   when 16..19
                     2
                   when 20..23
                     0
                   when 24..27
                     0
                   else
                     0
                 end

  if user1.wining_rate > user2.wining_rate
    user1.points += WIN_POINTS  #+ 2 * (user2.rank - user1.rank) + bonus_points
    user2.points -= LOSE_POINTS #+ 2 * (user2.rank - user1.rank)
    #user2.points = 0 if user2.points < 0
  else
    user2.points += WIN_POINTS #+ 2 * (user1.rank - user2.rank) + bonus_points
    user1.points -= LOSE_POINTS #+ 2 * (user1.rank - user2.rank)
    #user1.points = 0 if user2.points < 0
  end

  user1.rank = user1.points / 100
  user2.rank = user2.points / 100
end


users = new_users

(300 * USER_COUNT).times do |i|
  game(users)

  if i % 100 == 0
    print_results(users)
    p "========================================="
  end
end
