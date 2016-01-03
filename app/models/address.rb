class Address < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :first_name, :last_name, :street, :city, :state, :zipcode, :country
end