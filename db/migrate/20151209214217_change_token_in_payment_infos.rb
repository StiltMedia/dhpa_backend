class ChangeTokenInPaymentInfos < ActiveRecord::Migration
  def change
    remove_column :payment_infos, :token, :string
    add_column :payment_infos, :stripe_customer_id, :string
  end
end
