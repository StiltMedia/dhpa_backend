class Order < ActiveRecord::Base
  SHIPPING_PRICE = 5
  has_many :line_items, dependent: :destroy
  belongs_to :user
  belongs_to :payment_info
  belongs_to :order_shipping_info
  belongs_to :order_contact_info

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def add_additional_infos_from_cart(cart)
    self.order_shipping_info_id = generate_shipping_info_from(cart.address).id
    self.order_contact_info_id = cart.order_contact_info_id
    self.payment_info_id = cart.payment_info_id
  end

  private

    def generate_shipping_info_from(address)
      OrderShippingInfo.create(address.attributes.slice("first_name", "last_name", "street", "city", "state", "zipcode", "country"))
    end

end