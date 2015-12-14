class VipAtEvents < ActiveRecord::Migration
  def change
    create_table :vip_at_events do |t|
      t.integer :vip_id
      t.integer :event_id
    end
  end
end
