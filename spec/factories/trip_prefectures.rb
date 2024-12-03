FactoryBot.define do
  factory :trip_prefecture do
    association :trip
    association :prefecture
  end
end
