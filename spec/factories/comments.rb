FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.characters(number: rand(10..100)) }
    user
    group
  end
end