class AddNameToLightboxes < ActiveRecord::Migration
  def change
    add_column :lightboxes, :name, :string
  end
end
