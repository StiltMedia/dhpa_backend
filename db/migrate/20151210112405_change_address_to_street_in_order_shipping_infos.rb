class ChangeAddressToStreetInOrderShippingInfos < ActiveRecord::Migration
  def change
    remove_column :order_shipping_infos, :address, :string
    add_column :order_shipping_infos, :street, :string
    remove_column :order_shipping_infos, :zip_code, :string
    add_column :order_shipping_infos, :zipcode, :string
  end
end
