class SearchController < ApplicationController

  def search
    @events = Event.fuzzy_search(params[:q])
    @events = (@events + Event.tagged_with(params[:q], wild: true)).uniq
    @photos = Photo.fuzzy_search(params[:q])
    @photos = (@photos + Photo.tagged_with(params[:q], wild: true)).uniq
    @vips = Vip.fuzzy_search(params[:q])
  end

  def vip
    @vip = Vip.find(params[:id])
  end

end