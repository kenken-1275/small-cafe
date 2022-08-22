FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { '7a' + Faker::Internet.password(min_length: 6, mix_case: false) }
    password_confirmation { password }
    kanji_last_name { '山田' }
    kanji_first_name { '太郎' }
    hiragana_last_name { 'やまだ' }
    hiragana_first_name { 'たろう' }
  end
end
