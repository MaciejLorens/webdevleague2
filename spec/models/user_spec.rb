require 'spec_helper'

describe User do
  before(:each) do
    @skill = create :ruby_on_rails_skill
    @league = create :bronze2
    @division = create :division, league: @league, skill: @skill
    @user = create :user
    @member = create :member, division_id: @division.id, user_id: @user.id
    @user.members << @member
  end

  it 'has proper league assigned' do
    @user.skills.should_not be_empty
    @user.leagues.should_not be_empty
    @user.divisions.should_not be_empty
    @user.divisions.count.should == 1
    @user.members.should_not be_empty
    @user.members.count.should == 1
    @user.members.first.points.should == 50
  end

  context 'update_points' do
    before(:each) do
      @bronze1 = create :bronze1
      @bronze2 = create :bronze2
      @bronze3 = create :bronze3
      @bronze4 = create :bronze4
      @silver1 = create :silver1
      @grand_master4 = create :grand_master4
    end

    context 'when value is positive' do
      it 'adds value' do
        @user.update_points('Ruby on Rails', 7)
        @user.member_by_skill('Ruby on Rails').points.should == 57
      end
    end

    context 'when value is negative' do
      it 'subtract value' do
        @user.update_points('Ruby on Rails', -29)
        @user.member_by_skill('Ruby on Rails').points.should == 21
      end
    end

    context 'cause user jump to another' do
      context 'rank' do
        it 'when result is above 100 promote to next rank' do
          @user.member_by_skill('Ruby on Rails').league.is?('Bronze', 2).should be_true
          @user.member_by_skill('Ruby on Rails').points.should == 50
          @user.update_points('Ruby on Rails', 52)
          @user.member_by_skill('Ruby on Rails').points.should == 2
          @user.member_by_skill('Ruby on Rails').league.is?('Bronze', 3).should be_true
        end

        it 'when result is under 0 degrade to previous rank' do
          @user.member_by_skill('Ruby on Rails').league.is?('Bronze', 2).should be_true
          @user.member_by_skill('Ruby on Rails').points.should == 50
          @user.update_points('Ruby on Rails', -52)
          @user.member_by_skill('Ruby on Rails').points.should == 98
          @user.member_by_skill('Ruby on Rails').league.is?('Bronze', 1).should be_true
        end
      end

      context 'league' do
        it 'when result is above 100 and rank is 4 promote to next league' do
          league = create :bronze4
          @user.member_by_skill('Ruby on Rails').league = league

          @user.member_by_skill('Ruby on Rails').league.is?('Bronze', 4).should be_true
          @user.update_points('Ruby on Rails', 52)
          @user.member_by_skill('Ruby on Rails').points.should == 2
          @user.member_by_skill('Ruby on Rails').league.is?('Silver', 1).should be_true
        end

        it 'when result is under 0 and rank is 1 degrade to previous league' do
          league = create :silver1
          @user.member_by_skill('Ruby on Rails').league = league

          @user.member_by_skill('Ruby on Rails').league.is?('Silver', 1).should be_true
          @user.update_points('Ruby on Rails', -52)
          @user.member_by_skill('Ruby on Rails').points.should == 98
          @user.member_by_skill('Ruby on Rails').league.is?('Bronze', 4).should be_true
        end
      end
    end

    context 'cause NOT jump if' do
      it 'result is under 0 and user is bronze(1)' do
        league = create :bronze1
        @user.member_by_skill('Ruby on Rails').league = league

        @user.member_by_skill('Ruby on Rails').points.should == 50
        @user.update_points('Ruby on Rails', -59)
        @user.member_by_skill('Ruby on Rails').points.should == 0
        @user.member_by_skill('Ruby on Rails').league.is?('Bronze', 1).should be_true
      end

      it 'result is above 100 and user is grand_master(4)' do
        league = create :grand_master4
        @user.member_by_skill('Ruby on Rails').league = league

        @user.member_by_skill('Ruby on Rails').points.should == 50
        @user.update_points('Ruby on Rails', 59)
        @user.member_by_skill('Ruby on Rails').points.should == 109
        @user.member_by_skill('Ruby on Rails').league.is?('GrandMaster', 4).should be_true
        @user.update_points('Ruby on Rails', 236)
        @user.member_by_skill('Ruby on Rails').points.should == 345
        @user.member_by_skill('Ruby on Rails').league.is?('GrandMaster', 4).should be_true
      end
    end
  end
end
