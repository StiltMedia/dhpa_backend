$(document).on("upload:start", "form", function(e) {
    console.log("upload:start")
    $(this).find("input[type=submit]").attr("disabled", true)
});

$(document).on("upload:complete", "form", function(e) {
    if(!$(this).find("input.uploading").length) {
        console.log("upload:complete")
        $(this).find("input[type=submit]").removeAttr("disabled")
    }
});