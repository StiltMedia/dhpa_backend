class CreateVips < ActiveRecord::Migration
  def change
    create_table :vips do |t|
      t.string :name
    end
  end
end
