class CreateReserves < ActiveRecord::Migration[6.0]
  def change
    create_table :reserves do |t|
      t.date :date,                null:false
      t.integer :resavation_time_id,          null:false
      t.integer :people_number_id, null:false
      t.string :tel_number,        null:false
      t.references :user,          null:false,foreign_key:true
      t.timestamps
    end
  end
end
