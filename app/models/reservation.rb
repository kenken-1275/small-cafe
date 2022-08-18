class Reservation < ApplicationRecord


  validates :reservation_date,presence: true
  validates :reservation_time, presence: true
  validates :people_number, presence: true
  with_options presence: true do
    validates :tel_number,format:{with:/\A[0-9]{10,11}\z/,message: "is invalid."}
  end

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

end
