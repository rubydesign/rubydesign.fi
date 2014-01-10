//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require turbolinks
//= require jquery-barcode
//= require admin_scaffold
//= require foundation
//= require_self

$(function() {
   $( ".datepicker" ).datepicker( { dateFormat: 'dd/mm/yy' });
 });
 
function initPage(){
    bs_init();
}

$(window).bind('page:change', function() {
    initPage();
});