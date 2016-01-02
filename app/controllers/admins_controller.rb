class AdminsController < ApplicationController
  before_filter :check_if_admin

  def check_if_admin
    if current_user.present? && current_user.is_admin?
    else
      flash[:error] = "You do not have access to this area."
      redirect_to new_user_session_path
    end
  end

end