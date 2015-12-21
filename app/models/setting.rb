class Setting < ActiveRecord::Base

  def default_price_in_dollars=(dollars)
    self.default_price = dollars.to_d * 100 if dollars.present?
  end

  def default_price_in_dollars
    default_price.to_d / 100
  end

end
