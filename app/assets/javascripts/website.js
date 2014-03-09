// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs

$(document).ready(function() {
  // Hack to disable submit buttons when user clicks
  // $('form').submit(function(){
  //   if (!$(this).hasClass('nodis')) {
  //     $(this).find("input[type='submit']").attr('disabled', 'disabled');
  //     $(this).find("input[type='submit']").click(function(){ return false; });
  //   }
  // });

  // Main menu behaviour
  $('ul#main-menu li a').click(function(){
    prev = $(this).parent().parent().find("a.active").attr("rel");
    next = $(this).attr("rel");
    $(this).parent().parent().find("a.active").removeClass("active");
    $(this).addClass("active");
    $("div.content-left#" + prev).stop(true, true).fadeOut(250, function(){
     $("div.content-left#" + next).stop(true, true).fadeIn(250);
   });
    return false;
  });

  // Contact form functionality
  $('#contact-form').submit(function() {
    var valuesToSubmit = $(this).serialize();
    $.ajax({
        url: $(this).attr('action'), //sumbits it to the given url of the form
        data: valuesToSubmit,
        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(json){
      showContactResponseModal(json);
    });
    return false; // prevents normal behaviour
  });

  function showContactResponseModal(response) {
    $('#myModal').remove();
    $('body').append(
      "<div id='myModal' class='modal hide fade' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>" +
        "<div class='modal-header'>" +
          "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>" +
          "<h3 id='myModalLabel'>" + response['title'] + "</h3>" +
        "</div>" +
        "<div class='modal-body'>" +
          "<p>" + response['text'] + "</p>" +
        "</div>" +
        "<div class='modal-footer'>" +
          "<button class='btn btn-primary' data-dismiss='modal' aria-hidden='true'>" + I18n.t('close') + "</button>" +
        "</div>" +
      "</div>");
    $('#myModal').modal('show');
  }
});