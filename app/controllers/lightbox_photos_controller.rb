class LightboxPhotosController < ApplicationController

  before_filter :check_if_user

  def create
    # Find if possible
    if params[:lightbox_id].present?
      @lightbox = current_user.lightboxes.find(params[:lightbox_id])
    else
      @lightbox = current_user.lightboxes.where(active: true).first
      @lightbox = current_user.lightboxes.last if @lightbox.nil?
    end

    # Create if still none
    if @lightbox.nil?
      @lightbox = current_user.lightboxes.create
    end

    # Build LightboxPhoto
    @lightbox_photo = @lightbox.lightbox_photos.build(lightbox_photos_params)

    if @lightbox_photo.save
      flash.now[:success] = "Photo #{@lightbox_photo.photo.id} Added"
    else
      flash.now[:error] = "Error adding photo: #{@lightbox_photo.errors.full_messages.join('; ')}"
    end
  end

  def destroy
    @lightbox_photo = LightboxPhoto.find(params[:id])
    photo_id = @lightbox_photo.photo.id
    if @lightbox_photo.destroy
      flash.now[:success] = "Photo #{photo_id} Removed"
      render :create
    else
      flash.now[:error] = "Error removing photo: #{@lightbox_photo.errors.full_messages.join('; ')}"
      render :create
    end
  end

  private

    def lightbox_photos_params
      params.permit(:lightbox_id, :photo_id)
    end

    def check_if_user
      if current_user.present?
      else
        flash[:error] = "You do not have access to this area."
        redirect_to new_user_session_path
      end
    end

end