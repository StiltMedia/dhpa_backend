class ChangePricesInPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :price, :integer
    add_column :photos, :digital_price, :integer
    add_column :photos, :physical_price, :integer
    add_timestamps :photos
  end
end
