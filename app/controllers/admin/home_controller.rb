class Admin::HomeController < AdminsController
  skip_before_filter :check_if_admin
  before_filter :check_if_admin_or_photographer

  def index
    @events = Event.all.order(date: :desc)
  end
end