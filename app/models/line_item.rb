class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :photo
  belongs_to :order
  has_one :delivery_option
  accepts_nested_attributes_for :delivery_option

  def is_digital?
    delivery_option.option_type == "digital"
  end

  def is_physical?
    delivery_option.option_type == "physical"
  end

  def custom_price_in_dollars
    photo.digital_price_in_dollars
  end

  def custom_price
    photo.digital_price
  end

end

