class VipAtEvent < ActiveRecord::Base
  belongs_to :vip
  belongs_to :event
end