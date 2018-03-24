require 'spec_helper'

describe League do
  before(:each) do
    @league = create :league
  end

  context 'next' do
    before(:each) do
      create :silver2
      create :silver3
      create :silver4
      create :gold1
    end

    context 'return next rank' do
      it 'when rank < 4' do
        league = League.silver(2)
        league.league.should == 'Silver'
        league.rank.should == 2
        league.next.league.should == 'Silver'
        league.next.rank.should == 3
      end
    end

    context 'return next league' do
      it 'when rank == 4' do
        league = League.silver(4)
        league.league.should == 'Silver'
        league.rank.should == 4
        league.next.league.should == 'Gold'
        league.next.rank.should == 1
      end
    end
  end

  context 'previous' do
    before(:each) do
      create :bronze4
      create :silver1
      create :silver2
      create :silver3
    end

    context 'return previous rank' do
      it 'when rank > 1' do
        league = League.silver(3)
        league.league.should == 'Silver'
        league.rank.should == 3
        league.previous.league.should == 'Silver'
        league.previous.rank.should == 2
      end
    end

    context 'return previous league' do
      it 'when rank == 1' do
        league = League.silver(1)
        league.league.should == 'Silver'
        league.rank.should == 1
        league.previous.league.should == 'Bronze'
        league.previous.rank.should == 4
      end
    end
  end
end
