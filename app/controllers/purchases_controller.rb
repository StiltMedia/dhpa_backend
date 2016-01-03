class PurchasesController < ApplicationController
  before_action :set_order, only: [:show]

  def index
    @orders = current_user.orders
  end

  def show
  end

  private

    def set_order
      @order = Order.find(params[:id])
      if current_user != @order.user && guest_user != @order.user
        raise Errors::Forbidden
      end
    end
end