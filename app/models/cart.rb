class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :payment_info
  belongs_to :order_contact_info
  belongs_to :address

  def add_photo(photo_id, delivery_type_id)
    is_current_item = line_items.find_by(photo_id: photo_id)
    if is_current_item
      # TODO signal, that photo is already in cart
      current_item = line_items.new(photo_id: photo_id, delivery_type_id: delivery_type_id)
    else
      current_item = line_items.new(photo_id: photo_id, delivery_type_id: delivery_type_id)
    end
    current_item
  end

end