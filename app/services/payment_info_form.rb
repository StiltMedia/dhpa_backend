class PaymentInfoForm
  include ActiveModel::Model

  validates_presence_of :first_name, :last_name, :street, :city, :state, :zipcode, :country

  def initialize(user, cart)
    @user = user
    @cart = cart
  end

  attr_accessor :first_name, :last_name, :street, :city,
                :state, :zipcode, :country, :brand, :last4, :exp_month, :exp_year, :email

  def persisted?
    @cart.ready_to_purchase
  end

  def address
    @address ||= @user.addresses.new
  end

  def payment_info
    @payment_info ||= @user.payment_infos.new
  end

  def order_contact_info
    @order_contact_info ||= OrderContactInfo.new
  end

  def submit(payment_info_params, stripe_token)

    payment_info_params.each do |key, value|
      self.send("#{key}=", value)
    end

    address.attributes = payment_info_params.slice(:first_name, :last_name, :street, :city, :state, :zipcode, :country)
    order_contact_info.attributes = payment_info_params.slice(:email)

    if address.valid? && order_contact_info.valid?
      customer = generate_stripe_customer(stripe_token, @user.id)
      payment_info.attributes = payment_info_params.slice(:brand, :last4, :exp_month, :exp_year).merge(stripe_customer_id: customer.id)
      if payment_info.valid?
        address.save
        payment_info.save
        order_contact_info.save
        @cart.payment_info = payment_info
        @cart.order_contact_info = order_contact_info
        @cart.address = address
        @cart.ready_to_purchase = true
        if @cart.save
          true
        else
          @cart.errors.each do |e|
            self.errors.add(e)
          end
          false
        end
      else
        payment_info.errors.each do |e|
          self.errors.add(e)
        end
        false
      end
    else
      address.errors.each do |e|
        self.errors.add(e)
      end
      order_contact_info.errors.each do |e|
        self.errors.add(e)
      end
      false
    end
  end

  private

    def generate_stripe_customer(token, user_id)
      begin
        customer = Stripe::Customer.create(
          :source => token,
          :description => "UserID: #{user_id}"
        )
        customer

      rescue Stripe::CardError => e
        # Since it's a decline, Stripe::CardError will be caught
        body = e.json_body
        err  = body[:error]

        # puts "Status is: #{e.http_status}"
        # puts "Type is: #{err[:type]}"
        # puts "Code is: #{err[:code]}"
        # # param is '' in this case
        # puts "Param is: #{err[:param]}"
        # puts "Message is: #{err[:message]}"

        @status = :failed
        @error_message = err[:message]
        self

      rescue Stripe::RateLimitError => e
        # Too many requests made to the API too quickly
      rescue Stripe::InvalidRequestError => e
        # Invalid parameters were supplied to Stripe's API
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
      rescue => e
        # Something else happened, completely unrelated to Stripe
      end
    end

end