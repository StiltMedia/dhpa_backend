class Event < ActiveRecord::Base
  extend FriendlyId
    friendly_id :title, use: :slugged
  # has_many :vip_at_events
  # has_many :vips, through: :vip_at_events
  # accepts_nested_attributes_for :vips
  has_many :photos
  accepts_attachments_for :photos, attachment: :file, append: true
  attachment :image_url

  validates_presence_of :title, :image_url, :date
  validates_uniqueness_of :slug

  def is_private?
    return self.password.present? # Event is private if there's a password
  end

  def vips
    self.photos.collect{ |photo| photo.vips }.flatten
  end
end