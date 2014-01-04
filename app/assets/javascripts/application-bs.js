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
//= require turbolinks
//= require bootstrap-colorpicker
//= require bootstrap-datepicker
//= require bootstrap-timepicker
//= require bootstrap-datetimepicker-for-beautiful-scaffold
//= require jquery.jstree
//= require jquery-barcode
//= require beautiful_scaffold
//= require fixed_menu

function initPage(){
    bs_init();
}

$(window).bind('page:change', function() {
    initPage();
});