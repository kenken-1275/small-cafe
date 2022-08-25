class Reservation < ApplicationRecord

  validate :pretend_ago
  def pretend_ago
    if reservation_date.nil? || reservation_date < Date.today || reservation_date > Date.today + 31.day || reservation_date.wday == 1 || reservation_date.wday == 2 || reservation_date.wday == 3 
      errors.add(:reservation_date, 'は今日より１ヶ月以内の営業日を選択してください。') 
    end
  end
  with_options presence: true do
    validates :reservation_time, format:{with:/[1][1-6]:[00]/,message:"は選択肢から選んでください。"}
  end
  with_options presence: true do
    validates :people_number, format:{with:/[1-3]/,message:"は選択肢から選んでください。"}
  end
  with_options presence: true do
    validates :tel_number,format:{with:/\A[0-9]{10,11}\z/,message: "は正しく入力してください。"}
  end

  validate :max_people_number

  belongs_to :user

  

  OPEN_TIME = "11:00"
  CLOSE_TIME = "16:00"
  PER_TIME = 60.minutes

  MIN_PEOPLE_NUMBER = 1
  MAX_PEOPLE_NUMBER = 3 

  def self.time_option
    increment = PER_TIME.to_i
    from_time = Time.parse(OPEN_TIME).to_i
    to_time   = Time.parse(CLOSE_TIME).to_i
    from_time.step(to_time, increment).map { |m| Time.at(m).strftime('%H:%M') }
  end

  def time_option
    increment = PER_TIME.to_i
    from_time = Time.parse(OPEN_TIME).to_i
    to_time   = Time.parse(CLOSE_TIME).to_i
    from_time.step(to_time, increment).map { |m| Time.at(m).strftime('%H:%M') }
  end

  def people_number_option
    (MIN_PEOPLE_NUMBER..MAX_PEOPLE_NUMBER).map{|v| v}
  end

  def perse_reservation_time
    reservation_time.strftime('%H:%M')
  end

  private

  def max_people_number
    one_time_reservation_total = Reservation.where(reservation_date: reservation_date).where(reservation_time: reservation_time).sum(:people_number)
    if people_number.nil? || one_time_reservation_total + people_number >= 4
      errors.add(:people_number,"人数の指定が不正です。")
    end
  end
end
