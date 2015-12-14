$(document).on("page:update", function() {
    $("#item-options-tab #digital").on("click", function(e) {
        e.preventDefault();

        //hide physical form elements
        $("#physical-form-elements").hide()
        $("#physical-form-elements #line_item_delivery_option_attributes_option_type").prop("disabled", true)

        //show digital form elements
        $("#digital-form-elements").show()
        $("#digital-form-elements #line_item_delivery_option_attributes_option_type").prop("disabled", false)
    });

    $("#item-options-tab #physical").on("click", function(e) {
        e.preventDefault();

        //hide digital form elements
        $("#digital-form-elements").hide()
        $("#digital-form-elements #line_item_delivery_option_attributes_option_type").prop("disabled", true)

        //show digital form elements
        $("#physical-form-elements").show()
        $("#physical-form-elements #line_item_delivery_option_attributes_option_type").prop("disabled", false)
    });
});