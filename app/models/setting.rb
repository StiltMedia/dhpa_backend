class Setting < ActiveRecord::Base

  def personal_price_in_dollars=(dollars)
    self.personal_price = dollars.to_d * 100 if dollars.present?
  end

  def personal_price_in_dollars
    personal_price.to_d / 100
  end

  def commercial_price_in_dollars=(dollars)
    self.commercial_price = dollars.to_d * 100 if dollars.present?
  end

  def commercial_price_in_dollars
    commercial_price.to_d / 100
  end

end
