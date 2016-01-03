class Photo < ActiveRecord::Base

  attachment :file

  has_many :line_items
  belongs_to :event

  has_many :vip_at_photos
  has_many :vips, through: :vip_at_photos

  acts_as_taggable_on :tags

  extend FriendlyId
    friendly_id :name, use: :slugged

  before_destroy :ensure_not_referenced_by_any_line_item

  def commercial_price_in_dollars=(dollars)
    if dollars == "" || dollars == nil
      self.commercial_price = nil
    else
      self.commercial_price = dollars.to_d * 100
    end
  end

  def commercial_price_in_dollars
    if commercial_price
      commercial_price.to_d / 100
    end
  end

  def personal_price_in_dollars=(dollars)
    if dollars == "" || dollars == nil
      self.personal_price = nil
    else
      self.personal_price = dollars.to_d * 100
    end
  end

  def personal_price_in_dollars
    if personal_price
      personal_price.to_d / 100
    end
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