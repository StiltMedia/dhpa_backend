class Admin::PhotosController < AdminsController
  before_action :set_event
  def edit
    @photo = Photo.friendly.find(params[:id])
  end

  def update
    @photo = Photo.friendly.find(params[:id])
    if @photo.update(photo_params)
      flash[:success] = "Photo Updated"
      create_vips(@photo)
      redirect_to admin_event_path(@event)
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @photo = Photo.friendly.find(params[:id])
    if @photo.delete
      flash[:success] = "Photo Deleted"
      redirect_to admin_event_path(@event)
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  private
    def photo_params
      params.require(:photo).permit!
    end

    def set_event
      @event = Event.friendly.find(params[:event_id])
    end
end