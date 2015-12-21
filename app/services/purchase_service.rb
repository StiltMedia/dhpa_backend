class PurchaseService
  attr_reader :error_message

  def initialize(order)
    @order = order
  end

  def purchase(total_in_dollars, customer_id)

    begin
      charge = Stripe::Charge.create(
        :amount => (total_in_dollars * 100).round,
        :customer => customer_id,
        :currency => "usd"
      )

      @order.stripe_charge_id = charge.id
      @order.save

    # rescue Stripe::CardError => e
    #   # Since it's a decline, Stripe::CardError will be caught
    #   body = e.json_body
    #   err  = body[:error]

    #   # puts "Status is: #{e.http_status}"
    #   # puts "Type is: #{err[:type]}"
    #   # puts "Code is: #{err[:code]}"
    #   # # param is '' in this case
    #   # puts "Param is: #{err[:param]}"
    #   # puts "Message is: #{err[:message]}"

    #   @status = :failed
    #   @error_message = cerr[:message]
    #   self

    # rescue Stripe::RateLimitError => e
    #   # Too many requests made to the API too quickly
    # rescue Stripe::InvalidRequestError => e
    #   # Invalid parameters were supplied to Stripe's API
    # rescue Stripe::AuthenticationError => e
    #   # Authentication with Stripe's API failed
    #   # (maybe you changed API keys recently)
    # rescue Stripe::APIConnectionError => e
    #   # Network communication with Stripe failed
    # rescue Stripe::StripeError => e
    #   # Display a very generic error to the user, and maybe send
    #   # yourself an email
    rescue => e

      # Something else happened, completely unrelated to Stripe
    end

  end

  def successful?
    @status == :success
  end
end