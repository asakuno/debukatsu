FactoryBot.define do
  factory :food do
    food_name { Faker::Food.ingredient[0,20] }
    calorie { Faker::Number.between(from: 100, to: 1000) }
    price { Faker::Number.between(from: 100, to: 1000) }
    protein { Faker::Number.between(from: 1) }
    lipid { Faker::Number.between(from: 1) }
    sugar { Faker::Number.between(from: 1) }
    dietary_fiber { Faker::Number.between(from: 1) }
    table_salt { Faker::Number.between(from: 1) }
    user
  end
end