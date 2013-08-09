require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.build :user
  end

  it 'has proper league assigned' do
    @user.league.should == League.bronze(1)
    @user.league_id.should == League.first.id
    @user.points == 50
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
        @user.update_points(7)
        @user.points.should == 57
      end
    end

    context 'when value is negative' do
      it 'subtract value' do
        @user.update_points(-29)
        @user.points.should == 21
      end
    end

    context 'cause user jump to another' do
      context 'rank' do
        before(:each) do
          @user = create :user, league_id: @bronze2.id
        end

        it 'when result is above 100 promote to next rank' do
          @user.league.is?('Bronze', 2).should be_true
          @user.update_points(52)
          @user.points.should == 2
          @user.league.is?('Bronze', 3).should be_true
        end

        it 'when result is under 0 degrade to previous rank' do
          @user.league.is?('Bronze', 2).should be_true
          @user.update_points(-52)
          @user.points.should == 98
          @user.league.is?('Bronze', 1).should be_true
        end
      end

      context 'kind' do
        it 'when result is above 100 and rank is 4 promote to next kind' do
          user = create :user, league_id: @bronze4.id
          user.league.is?('Bronze', 4).should be_true
          user.update_points(52)
          user.points.should == 2
          user.league.is?('Silver', 1).should be_true
        end

        it 'when result is under 0 and rank is 1 degrade to previous kind' do
          user = create :user, league_id: @silver1.id
          user.league.is?('Silver', 1).should be_true
          user.update_points(-52)
          user.points.should == 98
          user.league.is?('Bronze', 4).should be_true
        end
      end
    end

    context 'cause NOT jump if' do
      it 'result is under 0 and user is bronze(1)' do
        user = create :user, league_id: @bronze1.id
        user.update_points(-52)
        user.points.should == 0
        user.league.is?('Bronze', 1).should be_true
      end

      it 'result is above 100 and user is bronze(1)' do
        user = create :user, league_id: @grand_master4.id
        user.update_points(52)
        user.points.should == 102
        user.league.is?('GrandMaster', 4).should be_true
      end
    end
  end
end
