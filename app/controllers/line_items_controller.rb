class LineItemsController < ApplicationController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper

  before_action :set_line_item, only: [:edit, :update, :destroy]

  def new
    @photo = Photo.find(params[:photo_id])
  end

  def create
    @line_item = LineItem.new(line_item_params.merge(cart_id: @cart.id))
    if @line_item.save
      flash[:notice] = "Added to cart. Price: #{number_to_currency calculate_price(@line_item, true)}"
      redirect_to :back
    else
      flash[:error] = "Error: Could not add to cart."
      redirect_to :back
    end
  end

  def edit
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to cart_path
    else

    end
  end

  def destroy
    @line_item.destroy
  end

  private

    def line_item_params
      params.require(:line_item).permit(:photo_id, delivery_option_attributes: [:option_type, :license, :nationality, :quantity, :border])
    end

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

end