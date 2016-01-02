class AddPersonalAndCommercialPricesToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :personal_price, :integer
    add_column :photos, :commercial_price, :integer
  end
end
