class PaymentInfo < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :brand, :exp_month, :exp_year, :last4
end