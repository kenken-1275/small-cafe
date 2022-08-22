class PastReservation < ApplicationRecord

  validates :reservation_date, presence:true
  validates :reservation_time, presence:true
  validates :people_number,    presence:true
  validates :tel_number,       presence:true
  validates :user_id,          presence:true

end
