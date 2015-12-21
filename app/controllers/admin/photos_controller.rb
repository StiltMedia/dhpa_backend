class Admin::PhotosController < AdminsController
  before_action :set_event
  def edit
    @photo = Photo.friendly.find(params[:id])
  end

  def update
    @photo = Photo.friendly.find(params[:id])
    if @photo.update(photo_params)
      create_vips(@photo)
      redirect_to edit_admin_event_path(@event)
      flash[:notice] = "Photo Updated"
    else

    end
  end

  def destroy
    @photo = Photo.friendly.find(params[:id])
    if @photo.delete
      redirect_to edit_admin_event_path(@event)
    else
      render :edit
      flash[:error] = "Something went wrong"
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