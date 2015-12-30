class Photo < ActiveRecord::Base
  SIZES = ["4x6", "5x7", "8x10", "10x14"]

  attachment :file

  has_many :line_items
  belongs_to :event

  has_many :vip_at_photos
  has_many :vips, through: :vip_at_photos

  extend FriendlyId
    friendly_id :name, use: :slugged

  before_save :parse_exif
  before_destroy :ensure_not_referenced_by_any_line_item

  def digital_price_in_dollars=(dollars)
    if dollars == "" || dollars == nil
      self.digital_price = nil
    else
      self.digital_price = dollars.to_d * 100
    end
  end

  def digital_price_in_dollars
    if digital_price
      digital_price.to_d / 100
    end
  end

  # def physical_price_4x6_in_dollars=(dollars)
  #   self.physical_price_4x6 = dollars.to_d * 100
  # end

  # def physical_price_4x6_in_dollars
  #   if physical_price_4x6
  #     physical_price_4x6.to_d / 100
  #   end
  # end

  # def physical_price_5x7_in_dollars=(dollars)
  #   self.physical_price_5x7 = dollars.to_d * 100
  # end

  # def physical_price_5x7_in_dollars
  #   if physical_price_5x7
  #     physical_price_5x7.to_d / 100
  #   end
  # end

  # def physical_price_8x10_in_dollars=(dollars)
  #   self.physical_price_8x10 = dollars.to_d * 100
  # end

  # def physical_price_8x10_in_dollars
  #   if physical_price_8x10
  #     physical_price_8x10.to_d / 100
  #   end
  # end

  # def physical_price_10x14_in_dollars=(dollars)
  #   self.physical_price_10x14 = dollars.to_d * 100
  # end

  # def physical_price_10x14_in_dollars
  #   if physical_price_10x14
  #     physical_price_10x14.to_d / 100
  #   end
  # end

  private


    def parse_exif
      exif = MiniExiftool.new self.file.download.path

      if exif.present? && exif.description.present?
        #Rails.logger.debug "EXIF DATA: "+self.to_hash.to_json

        # Description / Caption-Abstract / ImageDescription
        #Rails.logger.debug "EXIF_DESCR: "+self.description

        # Copyright / Artist / By-line / CopyrightNotice / Creator / Rights
        #Rails.logger.debug "EXIF_COPY: "+self.copyright

        # Extract copyright from EXIF
        self.copyright = exif.copyright
        # self.save

        # Add VIPs from EXIF Description
        vips = exif.description.split(",")
        Rails.logger.debug "VIPS: "+vips.to_s
        add_vips(vips, self)
      end
    end

    #TODO: this is duplicated in application_controller.rb, DRY
    def add_vips(vips, event_or_photo)
      if vips.present?
        vips.each do |vip|
          existing_vip = Vip.find_by_name("#{vip.strip}")
          if existing_vip.nil?
            unless vip.strip == ""
              # If there's no VIP yet, just make it
              result = event_or_photo.vips.create(name: "#{vip.strip}") # No trailing whitespace
            end
          else
            # Otherwise, add the VIP to this event_or_photo only if we need to
            unless event_or_photo.vips.include?(existing_vip)
              result = event_or_photo.vips << existing_vip
            end
          end
        end
      end
    end

    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end

end