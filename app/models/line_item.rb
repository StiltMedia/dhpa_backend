class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :photo
  belongs_to :order
  has_one :delivery_option
  accepts_nested_attributes_for :delivery_option
  
  validates_presence_of :delivery_option
  
  def self.editorial_license
    'editorial'
  end
  
  def self.personal_license
    'personal'
  end

  def self.licenses
    {LineItem::editorial_license => 'Editorial', LineItem::personal_license => 'Personal'}
  end
  
  def self.license_name(license)
    LineItem::licenses[license]
  end
  
  def self.personal_license_name
    LineItem::license_name(LineItem::personal_license)
  end
  
  def self.editorial_license_name
    LineItem::license_name(LineItem::editorial_license)
  end

  def is_digital?
    delivery_option.option_type == "digital"
  end

  def is_physical?
    delivery_option.option_type == "physical"
  end

  def is_commercial?
    delivery_option.license == LineItem::editorial_license
  end

  def is_personal?
    delivery_option.license == LineItem::personal_license
  end

  def custom_price_in_dollars
    if delivery_option.license == LineItem::editorial_license
      photo.commercial_price_in_dollars
    elsif delivery_option.license == LineItem::personal_license
      photo.personal_price_in_dollars
    else
      return nil
    end
  end

  def custom_price
    if delivery_option.license == LineItem::editorial_license
      photo.commercial_price
    elsif delivery_option.license == LineItem::personal_license
      photo.personal_price
    else
      return nil
    end
  end

end

