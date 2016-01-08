class LightboxPhoto < ActiveRecord::Base
  belongs_to :lightbox
  belongs_to :photo

  validates :photo, uniqueness: { scope: [:lightbox], message: "already added to this lightbox." }
end
