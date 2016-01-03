class PaymentInfosController < ApplicationController

  def new
    @payment_info = PaymentInfoForm.new(current_or_guest_user, @cart)
  end

  def create
    @payment_info = PaymentInfoForm.new(current_or_guest_user, @cart)

    if @payment_info.submit(payment_info_form_params, params[:stripe_token])
      flash.clear
      redirect_to confirm_path
    else
      flash[:error] = "Error creating payment: #{@payment_info.errors.full_messages.join('; ')}."
      render :new
    end
  end

  private

    def payment_info_form_params
      params.require(:payment_info_form)
        .permit(:first_name, :last_name, :street, :city, :state, :zipcode, :country, :brand, :last4, :exp_month, :exp_year, :email)
    end
end