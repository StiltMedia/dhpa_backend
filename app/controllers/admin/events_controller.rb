class Admin::EventsController < AdminsController
  before_action :set_event, only: [:show, :update, :delete]

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

  private
    def event_params
      params.require(:event).permit(:image_url, :title, :description, :sub_title, :location, :photographer, :is_featured, :password, :tag_list, :date, photos_files: [])
    end

    def set_event
      @event = Event.friendly.find(params[:id])
    end
end