class AddImageIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :image_id, :string
    add_column :photos, :size, :string
  end
end
