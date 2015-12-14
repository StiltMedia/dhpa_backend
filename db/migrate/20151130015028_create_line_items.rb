class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :cart_id
      t.integer :photo_id
      t.integer :order_id
      # t.integer :delivery_option_id

      t.timestamps
    end
    # add_index :line_items, :delivery_option_id
  end
end
