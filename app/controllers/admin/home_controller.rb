class Admin::HomeController < AdminsController
  def index
    @events = Event.all.order(date: :desc)
    @orders = Order.all.order(created_at: :desc)
  end
end