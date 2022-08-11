class CreateAnnounces < ActiveRecord::Migration[6.0]
  def change
    create_table :announces do |t|
      t.date :date,    null: false
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
