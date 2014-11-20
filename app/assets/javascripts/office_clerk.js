//= require jquery
//= require jquery-ui
//= require jquery-ui/datepicker-fi
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