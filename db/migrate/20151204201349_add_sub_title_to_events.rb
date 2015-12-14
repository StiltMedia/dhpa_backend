class AddSubTitleToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :sub_title, :string
  end
end
