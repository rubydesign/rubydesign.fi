//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require twitter/bootstrap/bootstrap-transition
//= require twitter/bootstrap/bootstrap-alert
//= require twitter/bootstrap/bootstrap-modal
//= require twitter/bootstrap/bootstrap-button
//= require twitter/bootstrap/bootstrap-collapse
//= require twitter/bootstrap/bootstrap-dropdown
//= require twitter/bootstrap/bootstrap-tooltip
//= require jquery.livequery
//= require turbolinks
//= require bootstrap-colorpicker
//= require bootstrap-datepicker
//= require bootstrap-timepicker
//= require bootstrap-datetimepicker-for-beautiful-scaffold
//= require jquery.jstree
//= require tagit.js
//= require chardinjs
//= require jquery-barcode
//= require beautiful_scaffold
//= require fixed_menu

function initPage(){
    datetimepicker_init();
    bs_init();
    modify_dom_init();
}
$(function() {
    initPage();
    function startSpinner(){
      $('.loader').show();
    }
    function stopSpinner(){
      $('.loader').hide();
    }
    document.addEventListener("page:fetch", startSpinner);
    document.addEventListener("page:receive", stopSpinner);
    document.addEventListener("page:restore", stopSpinner);
});
$(window).bind('page:change', function() {
    initPage();
});