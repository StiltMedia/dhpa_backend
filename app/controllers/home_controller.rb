class HomeController < ApplicationController
  def index
    @latest_events = Event.all.order(date: :desc).limit(9)
    @featured_events = Event.where(is_featured: true).order(date: :desc).limit(3)
    @top_featured_events = Event.where(is_top_featured: true).order(date: :desc).limit(3)
    instagram_url = "https://www.instagram.com/dhpamiami/media/"
    instagram_response = JSON.parse(open(instagram_url).read)

    # Return a blank array if all these conditions aren't satisifed
    unless (
      instagram_response.has_key?("items") &&
      instagram_response['items'].count > 0 &&
      instagram_response['items'][0].has_key?("link") &&
      instagram_response['items'][0].has_key?("caption") &&
      instagram_response['items'][0]['caption'].has_key?("text") &&
      instagram_response['items'][0].has_key?("images") &&
      instagram_response['items'][0]['images'].has_key?("low_resolution") &&
      instagram_response['items'][0]['images']['low_resolution'].has_key?("url")
    )
      @instagram_json = {'items' => Array.new}
      Rails.logger.error "Blank or invalid Instagram feed: #{instagram_url} returned: #{instagram_response.inspect}"
    else
      @instagram_json = instagram_response
    end

  end
end