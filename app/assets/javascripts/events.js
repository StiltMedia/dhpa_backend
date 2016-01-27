$(document).on("page:update", function() {

    $("#popup .btn-close").on("click", function(e) {
        $(this).parent().remove();
    });

    $(".toggle").on("click", function(e) {
        $(this).toggleClass('active');
        $($(this).data('target')).toggle();
    });
});

// refile upload progress
var uploadsSuccessful = 0;
var uploadsFailed = 0;
var uploadsCompleted = 0;
var uploadsTotal = 0;
var progressBarParent = null;

$(document).on("upload:start", "form", function(e) {
  $(this).find("input[type=submit]").attr("disabled", true);

  // store parent and create a total count indicator
  if (progressBarParent == null) {
    progressBarParent = $("#" + $(e.target).data("progressbarcontainer"));
    progressBarParent.append('<div id="uploadsCount">0 / 0 completed.</div>');
  }

  // remove original bar
  $("#" + $(e.target).data("progressbar")).parent().remove();
  
  // create new bar with indexed ID
  progressHtml = '<div class="progress hidden"><span class="progress-bar-label">'+e.originalEvent.detail.file.name+' : 0%</span>';
  progressHtml += '<div id="'+$(e.target).data("progressbar")+e.originalEvent.detail.index+'" ';
  progressHtml += 'aria-valuemax="100" aria-valuemin="0" aria-valuenow="0" class="progress-bar" role="progressbar" style="width: 0%;"></div></div>';

  progressBarParent.append(progressHtml);

  // add to total count
  uploadsTotal++;
});

$(document).on("upload:progress", "form", function(e) {
  // Get the progress bar to modify
  progressBar = $("#" + $(e.target).data("progressbar")+e.originalEvent.detail.index);
  // show entire bar
  progressBar.parent().removeClass('hidden');

  // Process upload details to get the percentage complete
  uploadDetail = e.originalEvent.detail;
  percentageComplete = Math.round((uploadDetail.progress.loaded / uploadDetail.progress.total) * 100);
  if (Number.isNaN(percentageComplete)) {
    percentageComplete = 0;
  }

  // Reflect the percentage on the progress bar
  progressBar.css("width", percentageComplete + "%");
  progressText = e.originalEvent.detail.file.name+' : '+percentageComplete+'%';
  progressBar.siblings('.progress-bar-label').text(progressText);
  
});

$(document).on("upload:success", "form", function(e) {
  progressBar = $("#" + $(e.target).data("progressbar")+e.originalEvent.detail.index);
  progressBar.addClass("progress-bar-success");
  
  // add to successful count
  uploadsSuccessful++;

  progressBar.parent().addClass("progress-finished"); // hide entire bar
});

$(document).on("upload:failure", "form", function(e) {
  progressBar = $("#" + $(e.target).data("progressbar")+e.originalEvent.detail.index);
  progressBar.addClass("progress-bar-danger");
  
  // add to failed count
  uploadsFailed++;
});

$(document).on("upload:complete", "form", function(e) {
  progressBar = $("#" + $(e.target).data("progressbar")+e.originalEvent.detail.index);
  
  finishedMessage = "";

  if(!$(this).find("input.uploading").length) {
    $(this).find("input[type=submit]").removeAttr("disabled");
    finishedMessage = '<b> -- Please click Submit to finish the upload, and wait while the images are processed.</b>';
  }

  // add to completed count
  uploadsCompleted++;
  
  if (uploadsFailed > 0) {
    $("#uploadsCount").html(uploadsCompleted+' / '+uploadsTotal+' completed ('+uploadsFailed+' failed)'+finishedMessage);
  } else {
    $("#uploadsCount").html(uploadsCompleted+' / '+uploadsTotal+' completed'+finishedMessage);
  }

  
});