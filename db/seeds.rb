# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  kanji_last_name: "管理",
  kanji_first_name: "者",
  hiragana_last_name: "かんり",
  hiragana_first_name: "しゃ",
  admin: true
)

Reservation.create!(
  reservation_date: "2022-08-25",
  reservation_time: '11:00',
  people_number: "2",
  tel_number: "08000000000",
  user: "1"
)