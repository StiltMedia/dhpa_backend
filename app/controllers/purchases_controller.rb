class PurchasesController < ApplicationController
  before_action :set_order
  
  def show
  end

  private

    def set_order
      @order = Order.find(params[:order_id])
    end
end