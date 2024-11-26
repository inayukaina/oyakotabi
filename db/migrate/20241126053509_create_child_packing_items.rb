class CreateChildPackingItems < ActiveRecord::Migration[7.0]
  def change
    create_table :child_packing_items do |t|
      t.references :trip, null: false, foreign_key:true
      t.string :name, null: false
      t.integer :quantity, default: 1
      t.boolean :is_event_completed, default: false

      t.timestamps
    end
  end
end
