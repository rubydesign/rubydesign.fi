//= require jquery
//= require jquery_ujs
//= require best_in_place

//= require jquery-ui
//= require jquery-ui/datepicker-fi
//= require best_in_place.jquery-ui

//= require bootstrap
//= require_self

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
});
