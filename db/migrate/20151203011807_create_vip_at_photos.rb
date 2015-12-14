class CreateVipAtPhotos < ActiveRecord::Migration
  def change
    create_table :vip_at_photos do |t|
      t.integer :vip_id
      t.integer :photo_id
    end
  end
end
