class AddPersonalImageSizeToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :personal_image_size, :integer
  end
end
