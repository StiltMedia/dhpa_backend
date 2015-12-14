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

  def price
    is_digital? ? photo.digital_price_in_dollars : calculate_physical_price
  end

  private

    def calculate_physical_price
      case delivery_option.size
      when "4x6"
        return photo.physical_price_4x6_in_dollars * delivery_option.quantity if photo.physical_price_4x6_in_dollars
      when "5x7"
        return photo.physical_price_5x7_in_dollars * delivery_option.quantity if photo.physical_price_5x7_in_dollars
      when "8x10"
        return photo.physical_price_8x10_in_dollars * delivery_option.quantity if photo.physical_price_8x10_in_dollars
      when "10x14"
        return photo.physical_price_10x14_in_dollars * delivery_option.quantity if photo.physical_price_10x14_in_dollars
      end
    end

end

