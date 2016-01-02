class PaymentInfosController < ApplicationController

  def new
    @payment_info = PaymentInfoForm.new(current_or_guest_user, @cart)
  end

  def create
    @payment_info_form = PaymentInfoForm.new(current_or_guest_user, @cart)

    if @payment_info_form.submit(payment_info_form_params, params[:stripe_token])
      redirect_to confirm_path
    else
      render :new
      flash[:error] = "Error"
    end
  end

  private

    def payment_info_form_params
      params.require(:payment_info_form)
        .permit(:first_name, :last_name, :street, :city, :state, :zipcode, :country, :brand, :last4, :exp_month, :exp_year, :email)
    end
end