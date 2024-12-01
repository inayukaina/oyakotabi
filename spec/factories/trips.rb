FactoryBot.define do
  factory :trip do
    association :user
    budget_total {100000}
    start_date {Date.today}
    end_date {Date.today + 3}
  end
end
