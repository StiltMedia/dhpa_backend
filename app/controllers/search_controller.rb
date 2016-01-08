class SearchController < ApplicationController

  def search
    @events = Event.fuzzy_search(params[:q])
    @events = (@events + Event.tagged_with(params[:q], wild: true)).uniq
    @events = @events.sort_by(&:date).reverse

    @photos = Photo.fuzzy_search(params[:q])
    @photos = (@photos + Photo.tagged_with(params[:q], wild: true)).uniq
    @photos = @photos.sort_by(&:created_at).reverse

    @vips = Vip.fuzzy_search(params[:q]).sort_by(&:name)
  end

  def vip
    @vip = Vip.find(params[:id])
    @vip_photos = @vip.photos.joins(:event).where("events.password IS NULL").order(created_at: :desc)
  end

end