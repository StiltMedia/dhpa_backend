class RemoveDigitalPriceFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :digital_price, :integer
    remove_column :photos, :image_id, :string
    remove_column :photos, :physical_price_4x6, :integer
    remove_column :photos, :physical_price_5x7, :integer
    remove_column :photos, :physical_price_8x10, :integer
    remove_column :photos, :physical_price_10x14, :integer
  end
end
