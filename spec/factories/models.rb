FactoryBot.define do
  factory :model do
    name { Faker::Commerce.product_name }
  end
end
