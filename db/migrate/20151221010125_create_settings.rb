class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :default_price

      t.timestamps null: false
    end
  end
end
