class CreateOrderContactInfo < ActiveRecord::Migration
  def change
    create_table :order_contact_infos do |t|
      t.string :email, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
