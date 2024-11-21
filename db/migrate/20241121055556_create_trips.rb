class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key:true
      t.integer :budget_total, default: 0
      t.date :start_date
      t.date :end_date
      t.text :notes
      t.timestamps
    end
  end
end
