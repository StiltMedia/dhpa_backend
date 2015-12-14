class ChangeOrderPaymentInfoId < ActiveRecord::Migration
  def change
    remove_column :orders, :payment_information_id, :integer
    add_column :orders, :payment_info_id, :integer
  end
end
