//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require turbolinks
//= require jquery-barcode
//= require admin_scaffold

function initPage(){
    bs_init();
}

$(window).bind('page:change', function() {
    initPage();
});