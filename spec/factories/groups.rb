FactoryBot.define do
  factory :group do
    group_name { Faker::Food.ingredient[0,20] }
    maximum_amount { Faker::Number.between(from: 10000, to: 30000) }
    publish { true }
    after(:create) do |group|
      foods = Food.all.sample(rand(1..5))
      group.foods << foods
    end
    user
  end
end