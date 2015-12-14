class CartsController < ApplicationController
  include CurrentCart

  before_action :set_cart

  def show
    @sub_total = @cart.sub_total
  end
end