class Lightbox < ActiveRecord::Base
  belongs_to :user
  has_many :lightbox_photos, dependent: :destroy
  has_many :photos, through: :lightbox_photos

  validates_presence_of :name
end
