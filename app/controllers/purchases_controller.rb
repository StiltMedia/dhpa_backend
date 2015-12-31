class PurchasesController < ApplicationController
  before_action :set_order

  def show
  end

  private

    def set_order
      @order = Order.find(params[:order_id])
      if current_user != @order.user && guest_user != @order.user
        raise Errors::Forbidden
      end
    end
end