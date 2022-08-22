class CreatePastReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :past_reservations do |t|
      t.date :reservation_date,       null:false
      t.time :reservation_time,       null:false
      t.integer :people_number,       null:false
      t.string :tel_number,           null:false
      t.integer :user_id,             null:false
      t.string :name
      t.timestamps
    end
  end
end
