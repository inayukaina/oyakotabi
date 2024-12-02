FactoryBot.define do
  factory :trip do
    association :user
    budget_total { 100000 }
    start_date { Date.today }
    end_date { Date.today + 3 }

    after(:create) do |trip|
      trip.prefectures << FactoryBot.create(:prefecture) # 都道府県を1つ関連付け
    end
  end
end
