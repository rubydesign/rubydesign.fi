//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require turbolinks
//= require jquery-barcode
//= require admin_scaffold
//= require foundation
//= require_self

function initPage(){
    bs_init();
}

$(window).bind('page:change', function() {
    initPage();
});