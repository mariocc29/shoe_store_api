FactoryBot.define do
  factory :store do
    name { Faker::Alphanumeric.alpha(number: 10) }
  end
end
