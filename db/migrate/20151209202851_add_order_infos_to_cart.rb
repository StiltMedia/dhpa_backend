class AddOrderInfosToCart < ActiveRecord::Migration
  def change
    add_column :carts, :order_contact_info_id, :integer
    add_column :carts, :address_id, :integer
  end
end
