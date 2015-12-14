class CreateOrderShippingInfo < ActiveRecord::Migration
  def change
    create_table :order_shipping_infos do |t|
      t.string :first_name,     null: false
      t.string :last_name,      null: false
      t.string :address,        null: false
      t.string :zip_code,       null: false
      t.string :city,           null: false
      t.string :country,        null: false
      t.string :state,          null: false

      t.timestamps
    end
  end
end
