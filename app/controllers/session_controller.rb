class SessionController < ApplicationController

  def create_session_password
    session[:session_password] = params[:password]
    redirect_to :back
  end

end