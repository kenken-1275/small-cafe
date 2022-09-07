class StoreHoliday < ApplicationRecord
  validates :store_holiday,presence:true,uniqueness: true
end
