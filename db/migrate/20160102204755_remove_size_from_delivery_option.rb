class RemoveSizeFromDeliveryOption < ActiveRecord::Migration
  def change
    remove_column :delivery_options, :size
  end
end
