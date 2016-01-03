$(document).on("page:change", function() {

    $('#payment-form').submit(function(e) {
        e.preventDefault();
        var $form = $(this);
        $form.find('input[type=submit]')
            .prop('disabled', true)
            .data('oldvalue', $('#payment-form input[type=submit]').val());
            .val("Please Wait...");

        var stripeKey = $form.data("stripe-key")
        Stripe.setPublishableKey(stripeKey);

        Stripe.createToken($form, stripeResponseHandler);
    });

});

var stripeResponseHandler = function(status, response) {
  var $form = $('#payment-form');

  console.log(response);
  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message);
    $form.find('input[type=submit]')
        .prop('disabled', false);
        .val($('#payment-form input[type=submit]').data('oldvalue'));
  } else {
    // token contains id, last4, and card type
    var token = response.id,
        brand = response.card.brand,
        last4 = response.card.last4,
        exp_month = response.card.exp_month,
        exp_year = response.card.exp_year;

    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripe_token" />').val(token));
    $form.append($('<input type="hidden" name="payment_info_form[brand]" />').val(brand));
    $form.append($('<input type="hidden" name="payment_info_form[last4]" />').val(last4));
    $form.append($('<input type="hidden" name="payment_info_form[exp_month]" />').val(exp_month));
    $form.append($('<input type="hidden" name="payment_info_form[exp_year]" />').val(exp_year));

    // and submit
    $form.get(0).submit();
  }
};