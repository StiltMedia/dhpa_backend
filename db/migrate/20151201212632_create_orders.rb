class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_shipping_info_id, null: false
      t.integer :order_contact_info_id,  null: false
      t.integer :payment_information_id, null: false

      t.timestamps
    end
  end
end
