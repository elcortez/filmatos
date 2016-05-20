$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip({
      placement : 'left'
  });
  $(".btn-group").hover(
    function(event) {
      console.log("helo")
      $(this).addClass('fa-spin');
    },
    function(event) {
      $(this).removeClass('fa-spin');
    }
  );
});
