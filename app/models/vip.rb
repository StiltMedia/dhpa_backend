class Vip < ActiveRecord::Base
  has_many :vip_at_events
  has_many :events, through: :vip_at_events
end