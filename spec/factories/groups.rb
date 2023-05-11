FactoryBot.define do
  factory :group do
    group_name { Faker::Food.ingredient[0,20] }
    maximum_amount { Faker::Number.between(from: 100, to: 30000) }
    publish  { Faker::Boolean.boolean }
    after(:create) do |group|
      # Create a random number of select_foods records for the group
      foods = Food.all.sample(rand(1..5))
      group.foods << foods
    end
    user
  end
end