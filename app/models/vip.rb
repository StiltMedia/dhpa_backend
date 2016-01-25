class Vip < ActiveRecord::Base
  has_many :vip_at_events
  has_many :events, through: :vip_at_events
  has_many :vip_at_photos
  has_many :photos, through: :vip_at_photos

  validates_uniqueness_of :name
end