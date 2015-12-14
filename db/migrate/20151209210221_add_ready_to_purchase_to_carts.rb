class AddReadyToPurchaseToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :ready_to_purchase, :boolean, default: false
  end
end
