// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require jquery-ui

//= require bootstrap/transition
//= require bootstrap/modal
//= require bootstrap/alert
//= require moment
//= require_directory ./other
//= require jquery.cookie

//= require cloudinary
//= require elastislide/modernizr.custom.17475
//= require elastislide/elastislide
//= require pikabu
//= require_directory ./shopping
//= stub ./shopping/details_autocomplete
//= require_directory ./account
//= require product
//= require footer
//= require zeroclipboard
//= require tablesaw.stackonly
//= require react
//= require react_ujs
//= require components

//= require bootstrap-hover-dropdown.min

$(document).ready(function(){

  var offset = 220;
  var duration = 1;
  $(window).scroll(function() {
    if ($(this).scrollTop() > offset) {
      $('.back-to-top').fadeIn(duration);
    } else {
      $('.back-to-top').fadeOut(duration);
    }
  });

  $('.back-to-top').click(function(event) {
    event.preventDefault();
    $('html, body').animate({scrollTop: 0}, duration);
    return false;
  })

  var pikabu = new Pikabu({
    viewportSelector: '.pikabu-viewport',
    widths: {
      left: '80%'
    }
  });

  // Copy to clipboard
  var client = new ZeroClipboard( document.getElementById("copy-button") );
  client.on("ready", function(readyEvent) {
    client.on("aftercopy", function(event) {
      $('#copy-success').show();
    });
  });

  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $(".pagination li a[rel='next']").first().attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 600) {

        $('.pagination').html( '<div class="sk-wave"> \
                                  <div class="sk-rect sk-rect1"></div> \
                                  <div class="sk-rect sk-rect2"></div> \
                                  <div class="sk-rect sk-rect3"></div> \
                                  <div class="sk-rect sk-rect4"></div> \
                                  <div class="sk-rect sk-rect5"></div> \
                                </div>' );

        return $.getScript(url);
      }
    });
    return $(window).scroll();
  }
});
