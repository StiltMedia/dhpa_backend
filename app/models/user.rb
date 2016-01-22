class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :lightboxes, dependent: :destroy
  has_many :payment_infos, dependent: :destroy
  has_many :addresses
  has_many :orders

  validates_presence_of :first_name, :last_name, :email

  def is_admin?
    self.is_admin == true
  end

  def is_admin_or_photographer?
    self.is_admin == true || self.is_photographer == true
  end
end
