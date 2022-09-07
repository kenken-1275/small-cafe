class CreateStoreHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :store_holidays do |t|
      t.date :store_holiday,null:false,unique:true
      t.timestamps
    end
  end
end
