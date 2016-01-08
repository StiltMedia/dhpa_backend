class Lightbox < ActiveRecord::Base
  belongs_to :user
  has_many :lightbox_photos
  has_many :photos, through: :lightbox_photos
end
