//= require jquery.min
//= require popper
//= require bootstrap

//= require best_in_place
//= require best_in_place.jquery-ui

//= require jquery-ui/datepicker
//= require jquery-ui/datepicker-fi

//= require_self

//= require vue

$.datepicker.setDefaults( $.datepicker.regional[ 'fi' ] );

$(function() {
   $( ".datepicker" ).datepicker( );
 });

function initPage(){
  // Add Error Form style with bootstrap
  $("div.form-group>div.field_with_errors").parent().addClass("error");
  $("#error_explanation").addClass("text-error");

}
$(window).bind('page:change', function() {
    initPage();
});

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  /* and fading alerts */
  jQuery(".alert").delay(5000).fadeOut("slow");
});
