class PastReservation < ApplicationRecord

  validates :reservation_date, presence:true
  validates :reservation_time, presence:true
  validates :people_number,    presence:true
  validates :tel_number,       presence:true
  validates :user_id,          presence:true

  belongs_to :user

  def self.search(keyword,date)
    if keyword.blank? && date.blank?
      return PastReservation.all
    end

    if keyword.present? && date.blank?
      return PastReservation.joins(:user).where(["tel_number like? OR name like? OR users.kanji_last_name like? OR users.kanji_first_name like? OR users.hiragana_last_name like? OR users.hiragana_first_name like?", "%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
    end

    if keyword.blank? && date.present?
      return PastReservation.joins(:user).where(reservation_date: date) 
    end

    if keyword.present? && date.present?
      return PastReservation.joins(:user).where(["reservation_date=? OR tel_number like? OR name like? OR users.kanji_last_name like? OR users.kanji_first_name like? OR users.hiragana_last_name like? OR users.hiragana_first_name like?", date,"%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
    end
  end

end