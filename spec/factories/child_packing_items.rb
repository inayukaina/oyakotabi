FactoryBot.define do
  factory :child_packing_item do
    name { "Tシャツ" }
    quantity { 3 }
    association :trip
  end
end
