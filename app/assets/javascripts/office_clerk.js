//= require jquery
//= require jquery-ui
//= require jquery-ui/datepicker-fi
//= require opal
//= require opal_ujs
//= require bootstrap
//= require_self

$.datepicker.setDefaults( $.datepicker.regional[ 'fi' ] );

$(function() {
   $( ".datepicker" ).datepicker( );
 });
 
function initPage(){
  // Barcode
  $('.barcode').each(function(){
      $(this).barcode($(this).attr('data-barcode'), $(this).attr('data-type-barcode'));
  });

  // Add Error Form style with bootstrap
  $("div.form-group>div.field_with_errors").parent().addClass("error");
  $("#error_explanation").addClass("text-error");

}

$(window).bind('page:change', function() {
    initPage();
});