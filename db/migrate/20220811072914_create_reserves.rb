class CreateReserves < ActiveRecord::Migration[6.0]
  def change
    create_table :reserves do |t|
      t.date :resavation_date,                null:false
      t.time :resavation_time,          null:false
      t.integer :people_number, null:false
      t.string :tel_number,        null:false
      t.references :user,          null:false,foreign_key:true
      t.timestamps
    end
  end
end
