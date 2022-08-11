class Reserve < ApplicationRecord

  validates :date,presence: true
  validates :time_id,presence: true
  validates :people_number_id,presence: true
  validates :tel_number,presence: true
  validates :date,presence: true

  belngs_to :user
  
end
