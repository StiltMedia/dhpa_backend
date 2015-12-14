class VipAtPhoto < ActiveRecord::Base
  belongs_to :vip
  belongs_to :photo
end