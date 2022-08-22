FactoryBot.define do
  factory :reservation do
    reservation_date {'2022-08-25'}
    reservation_time {'11:00'}
    people_number {Faker::Number.between(from: 1, to: 3)}
    tel_number {Faker::Number.number(digits: 10)}
  end
end
