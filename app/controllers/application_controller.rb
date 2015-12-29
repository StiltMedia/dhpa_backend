class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_or_guest_user

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
    @cached_guest_user ||= User.find(session[:guest_user_id] ) #||= create_guest_user.id

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  after_filter :store_location

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
      # For example:
      # guest_comments = guest_user.comments.all
      # guest_comments.each do |comment|
        # comment.user_id = current_user.id
        # comment.save!
      # end
    end

    # def create_guest_user
    #   u = User.create(:last_name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    #   u.save!(:validate => false)
    #   session[:guest_user_id] = u.id
    #   u
    # end

    def create_vips(event_or_photo)

      if event_or_photo.class == "Event"
        # Parse EXIF for all photos
        event_or_photo.photos.each do |photo|
          parse_exif(photo)
        end
      elsif event_or_photo.class == "Photo"
        parse_exif(event_or_photo)
      end

      # Add VIPs manually specified in params
      @vips = params[:vips].split(",")
      if @vips.present?
        @vips.each do |vip|
          event_or_photo.vips.create(name: "#{vip.strip}") # No trailing whitespace
        end
      end
    end


    def parse_exif(photo)
      exif = MiniExiftool.new photo.file.download.path
      #Rails.logger.debug "EXIF DATA: "+photo.to_hash.to_json

      # Description / Caption-Abstract / ImageDescription
      #Rails.logger.debug "EXIF_DESCR: "+photo.description

      # Copyright / Artist / By-line / CopyrightNotice / Creator / Rights
      #Rails.logger.debug "EXIF_COPY: "+photo.copyright

      # Extract copyright from EXIF
      photo.copyright = exif.copyright

      # Add VIPs from EXIF Description
      vips = exif.description.split(",")
      Rails.logger.debug "VIPS: "+vips.to_s
      if vips.present?
        vips.each do |vip|
          result = photo.vips.create(name: "#{vip.strip}") # No trailing whitespace
          Rails.logger.debug "VIP_RESULT: "+result.to_s
        end
      end
    end

end
