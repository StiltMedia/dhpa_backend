class Admin::EventsController < AdminsController
  before_action :set_event, only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      create_vips(@event)
      redirect_to edit_admin_event_path(@event)
    else
      render :new
      flash[:error] = "Something went wrong."
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      create_vips(@event)
      redirect_to edit_admin_event_path(@event)
    else
      render :edit
      flash[:error] = "Something went wrong"
    end
  end

  private
    def event_params
      params.require(:event).permit(:image_url, :title, :description, :sub_title, :location, :photographer, :date, photos_files: [])
    end

    def set_event
      @event = Event.friendly.find(params[:id])
    end
end