//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require turbolinks
//= require_self

$(function() {
   $( ".datepicker" ).datepicker( { dateFormat: 'dd/mm/yy' });
 });
 
function initPage(){
  // Barcode
  $('.barcode').each(function(index){
      $(this).barcode($(this).attr('data-barcode'), $(this).attr('data-type-barcode'));
  });

  // Add Error Form style with bootstrap
  $("div.form-group>div.field_with_errors").parent().addClass("error");
  $("#error_explanation").addClass("text-error");

}

$(window).bind('page:change', function() {
    initPage();
});