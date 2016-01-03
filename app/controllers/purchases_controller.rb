class PurchasesController < ApplicationController
  before_action :set_order, only: [:show]

  def index
    if current_user.present?
      @orders = current_user.orders
    else
      raise Errors::Forbidden
    end
  end

  def show
  end

  private

    def set_order
      @order = Order.find(params[:id])
      # order user not current or guest user; not admin
      if current_user != @order.user && guest_user != @order.user && (current_user.nil? || !current_user.is_admin?)
        raise Errors::Forbidden
      end
    end
end