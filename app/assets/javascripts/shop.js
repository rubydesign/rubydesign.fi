
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_self

function shipmentSelected(){
  ship = $("input[name='shipmentOption']:checked").val();
  basket = $("#basket_total").text();
  $("#shipping_cost").text( ship );
  $("#order_total").text( parseFloat(ship.replace(",", ".")) + parseFloat(basket.replace(",", ".")));
}

$(function() {
   $("input[name='shipmentOption']").click(shipmentSelected);
});
