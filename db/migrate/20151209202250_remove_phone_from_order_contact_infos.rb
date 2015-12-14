class RemovePhoneFromOrderContactInfos < ActiveRecord::Migration
  def change
    remove_column :order_contact_infos, :phone, :string
  end
end
