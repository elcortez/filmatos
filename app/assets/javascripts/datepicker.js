$(document).ready(function () {
  $('.datepicker').datepicker({
    format: "dd/mm/yy",
    weekStart: 1,
    daysOfWeekHighlighted: "0,6",
    todayHighlight: true
  });
});
