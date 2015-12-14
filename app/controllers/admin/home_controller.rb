class Admin::HomeController < AdminsController
  def index
    @events = Event.all
  end
end