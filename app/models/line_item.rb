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
    if delivery_option.license == "Commercial Use"
      photo.commercial_price_in_dollars
    elsif delivery_option.license == "Personal Use"
      photo.personal_price_in_dollars
    else
      return nil
    end
  end

  def custom_price
    if delivery_option.license == "Commercial Use"
      photo.commercial_price
    elsif delivery_option.license == "Personal Use"
      photo.personal_price
    else
      return nil
    end
  end

end

