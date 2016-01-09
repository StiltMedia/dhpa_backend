class LightboxesController < ApplicationController

  before_filter :check_if_user
  before_action :set_lightbox, only: [:show, :edit, :update, :destroy]

  def index
    @lightboxes = current_user.lightboxes
  end

  def show
  end

  def new
    @lightbox = current_user.lightboxes.build
  end

  def create
    @lightbox = current_user.lightboxes.build(lightbox_params)
    if @lightbox.save
      flash[:success] = "Created lightbox."
      redirect_to lightbox_path(@lightbox)
    else
      flash[:error] = "Error: Could not create lightbox."
      redirect_to :back
    end
  end

  def edit
  end

  def update
    if @lightbox.update(lightbox_params)
      flash[:success] = "Updated lightbox."
      redirect_to lightbox_path(@lightbox)
    else
      flash[:error] = "Error: Could not update lightbox."
      redirect_to :back
    end
  end

  def add
    if params[:id].present?
      @lightbox = current_user.lightboxes.find(params[:id])
    else
      @lightbox = current_user.lightboxes.last
    end

    if @lightbox.nil?
      @lightbox = current_user.lightboxes.create
    end

    @photo = Photo.find(params[:photo])

    begin
      if @lightbox.present? && @photo.present? && @lightbox.photos << @photo
        @response = "Photo #{@photo.id} Added."
      else
        @response = "Error adding photo."
      end
    rescue Exception => e
      @response = "Error adding photo. (#{e.message})"
    end
  end

  def destroy
    @lightbox.destroy
  end

  private

    def lightbox_params
      params.require(:lightbox).permit(:name, lightbox_photos_attributes: [:photo_id])
    end

    def set_lightbox
      @lightbox = current_user.lightboxes.find(params[:id])
    end

    def check_if_user
      if current_user.present?
      else
        flash[:error] = "You do not have access to this area."
        redirect_to new_user_session_path
      end
    end

end