class Setting < ActiveRecord::Base
  validates_presence_of :personal_price, :commercial_price, :personal_image_size

  def personal_price_in_dollars=(dollars)
    if dollars.present?
      self.personal_price = dollars.to_d * 100
    else
      self.personal_price = nil
    end
  end

  def personal_price_in_dollars
    personal_price.to_d / 100 if personal_price.present?
  end

  def commercial_price_in_dollars=(dollars)
    if dollars.present?
      self.commercial_price = dollars.to_d * 100
    else
      self.commercial_price = nil
    end
  end

  def commercial_price_in_dollars
    commercial_price.to_d / 100 if commercial_price.present?
  end

end
