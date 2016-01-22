class Admin::EventsController < AdminsController
  skip_before_filter :check_if_admin
  before_filter :check_if_admin_or_photographer
  before_action :set_event, only: [:show, :update, :destroy]

  def show # Show is actually the edit form
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    handle_exif(@event)
    if @event.save
      flash[:success] = "Event created successfully."
      # create_vips(@event)
      redirect_to admin_event_path(@event)
      # Thread.new { GC.start }
    else
      flash[:error] = "Error creating event: #{@event.errors.full_messages.join('; ')}."
      render :new
    end
  end

  def update
    @event.assign_attributes(event_params)
    handle_exif(@event)
    if @event.save
      flash[:success] = "Event updated successfully."
      # create_vips(@event)
      redirect_to admin_event_path(@event)
      # Thread.new { GC.start }
    else
      flash[:error] = "Error updating event: #{@event.errors.full_messages.join('; ')}."
      render :show
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = "Event deleted."
      redirect_to admin_path
    else
      flash[:error] = "Error deleting event: #{@event.errors.full_messages.join('; ')}."
      redirect_to admin_path
    end
  end

  private
    def event_params
      params.require(:event).permit(:image_url, :title, :description, :sub_title, :location, :photographer, :is_featured, :is_top_featured, :password, :tag_list, :date, photos_files: [])
    end

    def set_event
      @event = Event.friendly.find(params[:id])
    end
end