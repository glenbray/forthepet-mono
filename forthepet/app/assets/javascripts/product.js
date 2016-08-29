// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {
  $('#signup form').submit(function(e) {
    $.cookie('forthepet-signup', true, { expires: 365, path: '/' });
  });

  if($.cookie('forthepet-signup') != 'true') {
    $('#signup').modal({
      show: true,
      backdrop: 'static',
    });

    $('#signup').on('hide.bs.modal', function (e) {
      $.cookie('forthepet-signup', true, { expires: 365, path: '/' });
    })
  }

  var current = 0,
    $preview = $('#preview'),
    $carouselEl = $('#carousel'),
    $carouselItems = $carouselEl.children(),
    carousel = $carouselEl.elastislide({
      current: current,
      minItems: 4,
      onClick: function(el, pos, evt) {
        changeImage(el, pos);
        evt.preventDefault();
      },
      onReady: function() {
        changeImage($carouselItems.eq(current), current);
      }
    });

  function changeImage(el, pos) {
    $preview.attr('src', el.data('preview'));
    $carouselItems.removeClass('current-img');
    el.addClass('current-img');
  }
});
