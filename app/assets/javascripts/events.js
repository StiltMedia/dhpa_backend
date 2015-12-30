$(document).on("page:update", function() {

    $("#popup .btn-close").on("click", function(e) {
        $(this).parent().remove();
    });

    $(".toggle").on("click", function(e) {
        $(this).toggleClass('active');
        $($(this).data('target')).toggle();
    });
});