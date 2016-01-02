class OrdersController < ApplicationController
  include OrderHelper
  include ApplicationHelper


  def new
    @order = Order.new
  end

  def create
    @order = current_or_guest_user.orders.new

    @order.add_line_items_from_cart(@cart)
    @order.add_additional_infos_from_cart(@cart)

    success = PurchaseService.new(@order).purchase(calculate_subtotal(@cart, dollars: true), @cart.payment_info.stripe_customer_id)
    session[:cart_id] = nil # Clear out cart for new order

    if success
      redirect_to purchased_path(order_id: @order.id)
    else
      render :new
    end

  end

  def create_guest_user
    generate_guest_user
    redirect_to checkout_path
  end

  private

    def generate_guest_user
      u = User.create(:last_name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
      u.save!(:validate => false)
      session[:guest_user_id] = u.id
      u
    end

end