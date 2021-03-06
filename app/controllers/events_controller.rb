class EventsController < ApplicationController
  before_action :set_event, only: :show

  def index
    @events = Event.all.order(date: :desc)
  end

  def show
    if @event.is_private? && session[:session_password] != @event.password
      render :password_prompt
    else
      @photos = @event.photos.order(id: :asc)
    end
  end

  private
    def set_event
      @event = Event.friendly.find(params[:id])
    end
end