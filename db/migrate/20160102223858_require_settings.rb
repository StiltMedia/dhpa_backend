class RequireSettings < ActiveRecord::Migration
  def change
    change_column :settings, :personal_price, :integer, null: false
    change_column :settings, :commercial_price, :integer, null: false
    change_column :settings, :personal_image_size, :integer, null: false
  end
end
