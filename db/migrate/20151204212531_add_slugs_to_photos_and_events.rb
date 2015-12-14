class AddSlugsToPhotosAndEvents < ActiveRecord::Migration
  def change
    add_column :photos, :slug, :string
    add_column :events, :slug, :string
  end
end
