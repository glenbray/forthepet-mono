$(document).ready(function() {
  $('#available_date').datetimepicker({
    format: 'DD/MM/YYYY hh:mm A',
    sideBySide: true,
    icons: {
              previous: "fa fa-arrow-circle-o-left",
              next: "fa fa-arrow-circle-o-right",
              time: "fa fa-clock-o",
              date: "fa fa-calendar",
              up: "fa fa-arrow-up",
              down: "fa fa-arrow-down"
           }
  });

  $('#ends_on').datetimepicker({
    format: 'DD/MM/YYYY hh:mm A',
    minDate: moment(),
    sideBySide: true,
    icons: {
              previous: "fa fa-arrow-circle-o-left",
              next: "fa fa-arrow-circle-o-right",
              time: "fa fa-clock-o",
              date: "fa fa-calendar",
              up: "fa fa-arrow-up",
              down: "fa fa-arrow-down"
           }
  });
});
