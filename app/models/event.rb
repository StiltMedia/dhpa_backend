class Event < ActiveRecord::Base
  extend FriendlyId
    friendly_id :title, use: :slugged
  # has_many :vip_at_events
  # has_many :vips, through: :vip_at_events
  # accepts_nested_attributes_for :vips
  has_many :photos
  before_destroy :ensure_photos_not_referenced_by_any_line_item

  accepts_attachments_for :photos, attachment: :file, append: true
  attachment :image_url

  acts_as_taggable_on :tags

  validates_presence_of :title, :image_url, :date
  validates_uniqueness_of :slug

  def is_private?
    return self.password.present? # Event is private if there's a password
  end

  def vips
    self.photos.collect{ |photo| photo.vips }.flatten
  end

  private

    def ensure_photos_not_referenced_by_any_line_item
      result = self.photos.map do |photo|
        if photo.line_items.present?
          self.errors.add(:base, 'Line Items present')
          return false
        end
      end

      if result.include?(false)
        return false
      else
        return true
      end
    end
end