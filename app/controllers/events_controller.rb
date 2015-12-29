class EventsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :set_event, only: [:show]

  def index
    @events = Event.all
  end

  def show
    @photos = @event.photos.all
  end

  private
    def set_event
      @event = Event.friendly.find(params[:id])
    end
end