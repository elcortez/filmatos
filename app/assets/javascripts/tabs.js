$(function(){

  $(".tab").on("click", function(event){
    // Change active tab
    $(".tab").removeClass("active");
    $(this).toggleClass('active');
    // Hide all tab-content (use class="hidden")
    $(".tab-content").addClass("hidden");
    // // Show target tab-content (use class="hidden")
    var content = $(this).data("target");
    $(content).removeClass("hidden");
  });

});
