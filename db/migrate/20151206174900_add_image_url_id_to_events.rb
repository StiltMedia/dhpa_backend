class AddImageUrlIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :image_url_id, :string
  end
end
