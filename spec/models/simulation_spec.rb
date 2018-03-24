require 'spec_helper'

describe User do
  before(:all) do
    @skill = create :ruby_on_rails_skill
    @league = create :bronze2
    @division = create :division, league: @league, skill: @skill
    #@user = create :user
    #@member = create :member, division_id: @division.id, user_id: @user.id
    #@user.members << @member
  end

  context 'create a banch of users and make games' do
    before(:each) do
      users = []
      10_000.times { |i| users.push "('aaa','aaa#{i}@aa.pl')" }
      User.connection.execute "INSERT INTO users (`nick`, `email`) VALUES #{users.join(", ")}"
    end

    it 'adds to owned questions' do
      p User.count
    end
  end
end
