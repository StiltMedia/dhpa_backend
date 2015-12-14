class AddPhysicalPricesToPhoto < ActiveRecord::Migration
  def change
    remove_column :photos, :physical_price, :integer
    add_column :photos, :physical_price_4x6, :integer
    add_column :photos, :physical_price_5x7, :integer
    add_column :photos, :physical_price_8x10, :integer
    add_column :photos, :physical_price_10x14, :integer
  end
end
