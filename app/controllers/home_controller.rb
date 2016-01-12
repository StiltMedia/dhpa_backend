class HomeController < ApplicationController
  def index
    @latest_events = Event.all.order(date: :desc).limit(9)
    @featured_events = Event.where(is_featured: true).order(date: :desc).limit(3)
    @top_featured_events = Event.where(is_top_featured: true).order(date: :desc).limit(3)
    @instagram_feed = Instagram.user_recent_media(801660842).take(10) #2307266226
  end
end