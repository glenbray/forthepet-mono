// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// Smooth scroll
$('a[href$="#"]').click(function(e) {
  if (location.pathname.replace(/^\//,'') === this.pathname.replace(/^\//,'') && location.hostname === this.hostname) {
    var target = $(this.hash);
    target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
    if (target.length) {
      $('html,body').animate({
        scrollTop: target.offset().top
      }, 1000);
      return false;
    }
    return false; // Failed
  }
});
