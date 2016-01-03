class PhotosController < ApplicationController
  before_action :set_photo, only: [:show]

  def show
    if @photo.event.is_private? && session[:session_password] != @photo.event.password
      @event = @photo.event
      render :password_prompt
    end
  end

  private

    def set_photo
      @photo = Photo.find(params[:id])
    end
end