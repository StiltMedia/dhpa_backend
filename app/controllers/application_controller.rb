class ApplicationController < ActionController::Base
  include CurrentCart
  before_action :set_cart

  after_filter :store_location

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_or_guest_user

  rescue_from Errors::Forbidden do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 404, :layout => false
  end

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry = false).reload.try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = false)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] )

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  private

    # called (once) when the user logs in, insert any code your application needs
    # to hand off from guest_user to current_user.
    def logging_in
    end

    def create_vips(event_or_photo)
      # Add VIPs manually specified in params (not from EXIF)
      if params[:vips].present?
        vips = params[:vips].split(",")
        add_vips(vips, event_or_photo)
      end
    end

    def add_vips(vips, event_or_photo)
      if vips.present?
        vips.each do |vip|
          existing_vip = Vip.find_by_name("#{vip.strip}")
          if existing_vip.nil?
            unless vip.strip == ""
              # If there's no VIP yet, just make it
              result = event_or_photo.vips.build(name: "#{vip.strip}") # No trailing whitespace
            end
          else
            # Otherwise, add the VIP to this event_or_photo only if we need to
            unless event_or_photo.vips.include?(existing_vip)
              result = event_or_photo.vips << existing_vip
            end
          end
        end
        # Save so that on next run-through the find_by_name doesn't accidentally create duplicates
        event_or_photo.save
      end
    end

    def handle_exif(event_or_photo)
      if event_or_photo.class.to_s == "Event"
        # Parse EXIF for all photos
        event_or_photo.photos.each do |photo|
          parse_exif(photo)
        end
      elsif event_or_photo.class.to_s == "Photo"
        parse_exif(event_or_photo)
      end
    end

    def parse_exif(photo)
      if (
        photo.present? &&
        (photo.changed? || photo.new_record?) &&
        photo.file.present? &&
        photo.file.download.present? &&
        photo.file.download.path.present?
      )
        magick = MiniMagick::Image.open photo.file.download.path

        if magick.present?
          if magick.width.present? && magick.height.present?
            # Extract dimensions from EXIF
            photo.size = "#{magick.width}x#{magick.height}"
          end
        end

        exif = MiniExiftool.new photo.file.download.path
        #Rails.logger.debug "EXIF DATA: "+photo.to_hash.to_json

        # Description / Caption-Abstract / ImageDescription
        #Rails.logger.debug "EXIF_DESCR: "+photo.description

        # Copyright / Artist / By-line / CopyrightNotice / Creator / Rights
        #Rails.logger.debug "EXIF_COPY: "+photo.copyright

        if exif.present?

          # Extract copyright from EXIF
          photo.copyright = exif.copyright

          if exif.description.present?

            # Add VIPs from EXIF Description
            vips = exif.description.split(",")
            Rails.logger.debug "VIPS: "+vips.to_s
            add_vips(vips, photo)
          end
        end
      end
    end
end
