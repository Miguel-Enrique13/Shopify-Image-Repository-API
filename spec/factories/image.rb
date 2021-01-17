FactoryBot.define do
  factory :image do
    description { Faker::Lorem.paragraph }
    title { Faker::Space.star }
    price { Faker::Commerce.price(range: 0..100.00) }
    inventory { Faker::Number.within(range: 0..100) }
    privacy { "privacy"}
    user
  end
end
