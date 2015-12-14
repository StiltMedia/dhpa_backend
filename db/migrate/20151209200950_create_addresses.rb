class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.integer :user_id

      t.timestamps
    end
    add_index :addresses, :user_id
  end
end