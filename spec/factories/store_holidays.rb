FactoryBot.define do
  factory :store_holiday do
    store_holiday{Faker::Date.in_date_period}
  end
end
