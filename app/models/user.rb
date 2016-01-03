class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :payment_infos, dependent: :destroy
  has_many :addresses
  has_many :orders

  def is_admin?
    self.is_admin == true
  end
end
