class CreatePaymentInfo < ActiveRecord::Migration
  def change
    create_table :payment_infos do |t|
      t.integer :user_id
      t.string :token,      null: false
      t.string :brand,      null: false
      t.integer :exp_month, null: false
      t.integer :exp_year,  null: false
      t.string :last4,      null: false

      t.timestamps
    end
  end
end
