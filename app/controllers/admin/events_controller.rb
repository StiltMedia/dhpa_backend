class Admin::EventsController < AdminsController
  before_action :set_event, only: [:edit, :update, :delete]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    handle_exif(@event)
    if @event.save
      flash[:success] = "Event created successfully."
      create_vips(@event)
      redirect_to edit_admin_event_path(@event)
      # Thread.new { GC.start }
    else
      flash[:error] = "Error creating event: #{@event.errors.full_messages.join('; ')}."
      render :new
    end
  end

  def edit
  end

  def update
    @event.assign_attributes(event_params)
    handle_exif(@event)
    if @event.save
      flash[:success] = "Event updated successfully."
      create_vips(@event)
      redirect_to edit_admin_event_path(@event)
      # Thread.new { GC.start }
    else
      flash[:error] = "Error updating event: #{@event.errors.full_messages.join('; ')}."
      render :edit
    end
  end

  private
    def event_params
      params.require(:event).permit(:image_url, :title, :description, :sub_title, :location, :photographer, :is_featured, :date, photos_files: [])
    end

    def set_event
      @event = Event.friendly.find(params[:id])
    end
end