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
      redirect_to lightboxes_path
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
      redirect_to lightboxes_path
    else
      flash[:error] = "Error: Could not update lightbox."
      redirect_to :back
    end
  end

  def switch_active
    valid = false
    
    current_user.lightboxes.each do |lightbox|
      if lightbox.id == params[:active_lightbox].to_i
        lightbox.active = true
        valid = true
        @lightbox = lightbox
      else
        lightbox.active = false
      end
    end

    @lightbox = current_user.lightboxes.where(active: true).first if @lightbox.nil?
    @lightbox = current_user.lightboxes.last if @lightbox.nil?

    if valid == true
      current_user.lightboxes.each do |lightbox|
        lightbox.save
      end
      flash.now[:success] = "Switched lightbox."
      render 'lightbox_photos/create'
    else
      flash.now[:error] = "Error: Could not switch lightbox."
      render 'lightbox_photos/create'
    end
  end

  def destroy
    if @lightbox.destroy
      flash[:success] = "Deleted lightbox."
      redirect_to lightboxes_path
    else
      flash[:error] = "Error deleting lightbox: #{@lightbox.errors.full_messages.join('; ')}."
      redirect_to :back
    end
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