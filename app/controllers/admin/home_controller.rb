class Admin::HomeController < AdminsController
  def index
    @events = Event.all.order(date: :desc)
  end
end