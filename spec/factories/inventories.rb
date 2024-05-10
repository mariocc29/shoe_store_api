FactoryBot.define do
  factory :inventory do
    association :store
    association :model
    stock { Faker::Number.between(from: 1, to: 10) }
  end
end
