//= require jquery.min
//= require jquery_ujs
//= require best_in_place

//= require jquery-ui/datepicker
//= require jquery-ui/datepicker-fi
//= require best_in_place.jquery-ui

//= require 'jquery.flot'
//= require 'jquery.flot.resize'
//= require 'jquery.flot.time'
//= require 'jquery.flot.stack'

//= require bootstrap.min
//= require_self

//= require printer
//= require vue
//= require chartist
//= require moment

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
