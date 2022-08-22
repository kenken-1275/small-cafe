FactoryBot.define do
  factory :announce do

    date {Faker::Date.in_date_period}
    title {Faker::Lorem.characters(number: 10)}
    content {Faker::Lorem.sentence}
    
  end
end
