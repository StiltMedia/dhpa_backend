$(document).on("page:update", function() {

    $("#popup .btn-close").on("click", function(e) {
        $(this).parent().remove();
    })
})