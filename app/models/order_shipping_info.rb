class OrderShippingInfo < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :street, :zipcode, :city, :country, :state
end