League::ALL_LEAGUE.each do |kind|
  (1..4).each do |rank|
    League.create(league: kind, rank: rank)
  end
end

Skill.create(name: 'Ruby on Rails')
Skill.create(name: 'Ruby')
Skill.create(name: 'HTML5')
Skill.create(name: 'CoffeeScript')
Skill.create(name: 'CSS3')

Skill.all.each do |skill|
  skill.leagues = League.all
end

admin = User.create(nick: "mcksnk", email: "mckl@poczta.fm", password: "samplepass")
Skill.all.each do |skill|
  division = Division.by_skill(skill.name).by_league('Bronze').by_rank(1).first
  admin.members.create(division_id: division.id, points: 50)
end

10.times do |i|
  user = User.create(nick: "mcksnk#{i}", email: "mckl#{i}@poczta.fm", password: "samplepass#{i}")
  Skill.all.each do |skill|
    division = Division.by_skill(skill.name).by_league('Bronze').by_rank(1).first
    user.members.create(division_id: division.id, points: 50)
  end
end

10.times do |i|
  question = Question.create(content: "question content#{i}")
  #admin.questions_users.create(question_id: question.id, owner: rand(2))
  question.answers.create(content: "answer content#{i}", correct: true)
  rand(5).times do |j|
    question.answers.create(content: "answer content#{j}", correct: rand(2))
  end
end
