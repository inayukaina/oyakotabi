class CreateTripPrefectures < ActiveRecord::Migration[7.0]
  def change
    create_table :trip_prefectures do |t|
      t.references :trip, null: false, foreign_key:true
      t.references :prefecture, null: false, foreign_key:true
      t.timestamps
    end
  end
end
