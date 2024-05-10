FactoryBot.define do
  factory :inventory do
    association :store
    association :model
    inventory { Faker::Number.between(from: 1, to: 10) }
  end
end
