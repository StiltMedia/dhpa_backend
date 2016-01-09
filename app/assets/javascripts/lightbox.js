$(document).on("page:update", function() {

    $(".toggle-lightbox").on("click", function(e) {
        $("#lightbox").slideToggle(500);
        if ($("#lightbox").is( ":visible")) {
            $(".toggle-lightbox").text("Hide Lightbox");
        } else {
            $(".toggle-lightbox").text("Show Lightbox");
        }
    });


    $('.top-images').slick({
        dots: true,
        infinite: false,
        speed: 300,
        slidesToScroll: 1,
        variableWidth: true,
        responsive: [
          {
            breakpoint: 1024,
            settings: {
              slidesToShow: 4,
              slidesToScroll: 4,
              infinite: true,
              dots: true
            }
          },
          {
            breakpoint: 600,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1
            }
          }
          // You can unslick at a given breakpoint now by adding:
          // settings: "unslick"
          // instead of a settings object
        ]
    });

});