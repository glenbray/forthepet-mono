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
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap.js
//= require tinymce-jquery
//= require cloudinary
//= require moment
//= require bootstrap-datetimepicker
//= require selectize
//= require_directory ./admin

$(document).ready(function() {
  $('.sortable').sortable({
    axis: "y",
    opacity: 0.9,
    placeholder: "sortable-placeholder",

    update: function(event, ui) {
      $.post($(this).data('sortable-url'), $(this).sortable('serialize'));
    },

    helper: function(e, tr) {
      var $originals = tr.children();
      var $helper = tr.clone();
      $helper.children().each(function(index)
      {
        $(this).width($originals.eq(index).width());
      });
      return $helper;
    },
  });
});
