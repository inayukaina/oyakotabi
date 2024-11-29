FactoryBot.define do
  factory :user do
    name              {'test'}
    email                 {'test@example'}
    password              {'000000a'}
    password_confirmation {password}
  end
end