class CreateDeliveryOptions < ActiveRecord::Migration
  def change
    create_table :delivery_options do |t|
      t.string :option_type, null: false
      t.string :license
      t.string :nationality
      t.integer :quantity
      t.string :border
      t.string :size
      t.integer :line_item_id

      t.timestamps
    end
    add_index :delivery_options, :line_item_id
  end
end
