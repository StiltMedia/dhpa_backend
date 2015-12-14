class AddIsFeaturedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_featured, :boolean
  end
end
