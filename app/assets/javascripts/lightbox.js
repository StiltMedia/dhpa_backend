$(document).on("page:update", function() {

    $(".toggle-lightbox").on("click", function(e) {
        $("#lightbox").toggle();
        if ($("#lightbox").is( ":visible")) {
            $(".toggle-lightbox").text("Hide Lightbox");
        } else {
            $(".toggle-lightbox").text("Show Lightbox");
        }
    });

});