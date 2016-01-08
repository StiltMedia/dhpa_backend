class CreateLightboxes < ActiveRecord::Migration
  def change
    create_table :lightboxes do |t|
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
