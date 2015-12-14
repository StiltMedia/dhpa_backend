class Photo < ActiveRecord::Base
  SIZES = ["4x6", "5x7", "8x10", "10x14"]

  attachment :file

  has_many :line_items
  belongs_to :event

  has_many :vip_at_photos
  has_many :vips, through: :vip_at_photos

  extend FriendlyId
    friendly_id :name, use: :slugged

  before_destroy :ensure_not_referenced_by_any_line_item

  def digital_price_in_dollars=(dollars)
    self.digital_price = dollars.to_d * 100 if dollars.present?
  end

  def digital_price_in_dollars
    digital_price.to_d / 100 if digital_price
  end

  def physical_price_4x6_in_dollars=(dollars)
    self.physical_price_4x6 = dollars.to_d * 100 if dollars.present?
  end

  def physical_price_4x6_in_dollars
    physical_price_4x6.to_d / 100 if physical_price_4x6
  end

  def physical_price_5x7_in_dollars=(dollars)
    self.physical_price_5x7 = dollars.to_d * 100 if dollars.present?
  end

  def physical_price_5x7_in_dollars
    physical_price_5x7.to_d / 100 if physical_price_5x7
  end

  def physical_price_8x10_in_dollars=(dollars)
    self.physical_price_8x10 = dollars.to_d * 100 if dollars.present?
  end

  def physical_price_8x10_in_dollars
    physical_price_8x10.to_d / 100 if physical_price_8x10
  end

  def physical_price_10x14_in_dollars=(dollars)
    self.physical_price_10x14 = dollars.to_d * 100 if dollars.present?
  end

  def physical_price_10x14_in_dollars
    physical_price_10x14.to_d / 100 if physical_price_10x14
  end

  private

    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end

end