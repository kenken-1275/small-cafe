class Reserve < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :resavation_time
  belongs_to :people_number

  validates :resavation_date,presence: true
  validates :resavation_time_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :people_number_id, numericality: { other_than: 1 , message: "can't be blank"}
  with_options presence: true do
    validates :tel_number,format:{with:/\A[0-9]{10,11}\z/,message: "is invalid."}
  end

  belongs_to :user

end
