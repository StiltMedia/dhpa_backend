class AddSplitPricingToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :personal_price, :integer
    add_column :settings, :commercial_price, :integer
    remove_column :settings, :default_price
  end
end
