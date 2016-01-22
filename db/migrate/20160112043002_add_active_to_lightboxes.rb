class AddActiveToLightboxes < ActiveRecord::Migration
  def change
    add_column :lightboxes, :active, :boolean
  end
end
