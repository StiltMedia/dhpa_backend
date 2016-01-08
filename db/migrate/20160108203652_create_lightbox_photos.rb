class CreateLightboxPhotos < ActiveRecord::Migration
  def change
    create_table :lightbox_photos do |t|
      t.references :lightbox, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
