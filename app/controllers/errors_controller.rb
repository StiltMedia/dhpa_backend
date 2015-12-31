class ErrorsController < ApplicationController
  def error403
    render :file => "#{Rails.root}/public/403.html", :status => 404, :layout => false
  end
  def error404
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  def error500
    render :file => "#{Rails.root}/public/500.html", :status => 404, :layout => false
  end
end