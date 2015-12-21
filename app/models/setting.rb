class Setting < ActiveRecord::Base

  def default_price_in_dollars=(dollars)
    self.default_price = dollars.to_d * 100 if dollars.present?
  end

  def default_price_in_dollars
    if default_price
      default_price.to_d / 100
    else
      0
    end
  end

end
