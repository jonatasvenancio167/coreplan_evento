FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    start_datetime { 1.day.from_now }
    end_datetime { 2.days.from_now }
    location { Faker::Address.city }
    capacity { Faker::Number.between(from: 1, to: 100) }
  end
end
