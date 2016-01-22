class AddIsTopFeaturedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_top_featured, :boolean
  end
end
