FactoryBot.define do
  factory :reserve do
    reserve_on             { Faker::Date.in_date_period }
    remark                 { Faker::Lorem.sentence }
    total_price            { Faker::Number.between(from: 0, to: 100_000) }
  end
end
