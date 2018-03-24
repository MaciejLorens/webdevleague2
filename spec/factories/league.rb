require 'factory_girl'

FactoryGirl.define do
  factory :league do
    league 'Bronze'
    rank 1

    factory :bronze1 do
      league 'Bronze'
      rank 1
    end

    factory :bronze2 do
      league 'Bronze'
      rank 2
    end

    factory :bronze3 do
      league 'Bronze'
      rank 3
    end

    factory :bronze4 do
      league 'Bronze'
      rank 4
    end

    factory :silver1 do
      league 'Silver'
      rank 1
    end

    factory :silver2 do
      league 'Silver'
      rank 2
    end

    factory :silver3 do
      league 'Silver'
      rank 3
    end

    factory :silver4 do
      league 'Silver'
      rank 4
    end

    factory :gold1 do
      league 'Gold'
      rank 1
    end

    factory :gold2 do
      league 'Gold'
      rank 2
    end

    factory :gold3 do
      league 'Gold'
      rank 3
    end

    factory :gold4 do
      league 'Gold'
      rank 4
    end

    factory :grand_master4 do
      league 'GrandMaster'
      rank 4
    end
  end
end
