class AdminsController < ApplicationController
  before_filter :check_if_admin

  def check_if_admin
    if current_user.present? && current_user.is_admin?
    else
      raise Errors::Forbidden
    end
  end

  def check_if_admin_or_photographer
    if current_user.present? && current_user.is_admin_or_photographer?
    else
      raise Errors::Forbidden
    end
  end
end