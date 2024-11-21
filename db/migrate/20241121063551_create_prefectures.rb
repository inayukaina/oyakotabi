class CreatePrefectures < ActiveRecord::Migration[7.0]
  def change
    create_table :prefectures do |t|
      t.string :name, null: false, unique: true
      t.string :region
      t.timestamps
    end
  end
end
