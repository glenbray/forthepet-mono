// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){

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

  $('.single-deal-time').countdown($('.single-deal-time').data('end'), function(event) {
    var totalDays = event.offset.totalDays;

    var $this = $(this).html(event.strftime(''
      + '<span>' + totalDays + '</span> days '
      + '<span>%H</span> hrs '
      + '<span>%M</span> min '
      + '<span>%S</span> sec'));
  });

  $('.deal-time').each(function() {
    unparsedDate = $(this).data('end');
    var finalDate = moment(unparsedDate).format('YYYY/MM/DD HH:mm:ss');

    $(this).countdown(finalDate, function(event) {
      var totalDays = event.offset.totalDays;
      var dateFormat = '';

      if (totalDays > 1) {
        dateFormat = '<span>' + totalDays + '</span> day%!d'
      } else {
        dateFormat = '<span>%-H</span>:'
                   + '<span>%M</span>:'
                   + '<span>%S</span>'
      }

      $(this).html(event.strftime(dateFormat));
    });
  });

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
