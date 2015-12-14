class HomeController < ApplicationController
  def index
    @latest_events = Event.all.order(date: :desc).limit(9)
    @instagram_feed = Instagram.user_recent_media(801660842).take(10)
  end
end