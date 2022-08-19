class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.date :reservation_date,    null:false
      t.time :reservation_time,    null:false
      t.integer :people_number,    null:false
      t.string :tel_number,        null:false
      t.references :user,          null:false,foreign_key:true
      t.string :name
      t.timestamps
    end
  end
end
