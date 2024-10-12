# spec/factories/registrations.rb
FactoryBot.define do
  factory :registration do
    participant_name { Faker::Name.name }
    participant_email { Faker::Internet.email }
    association :event
  end
end
