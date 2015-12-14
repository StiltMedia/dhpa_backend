class AddPaymentInfoIdToCart < ActiveRecord::Migration
  def change
    add_column :carts, :payment_info_id, :integer
  end
end
