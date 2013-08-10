League::ALL_LEAGUE.each do |kind|
  (1..4).each do |rank|
    League.create(league: kind, rank: rank)
  end
end

User.create(nick: 'mcksnk', email: 'mckl@poczta.fm', password: 'samplepass', league_id: League.bronze(1).id)
