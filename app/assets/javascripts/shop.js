
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

function fillAddress(){
  old = $("#previous_address");
  target = $("#address_form");
  target.find("#name").val( old.find(".name").text() )
  target.find("#street").val( old.find(".street").text() )
  target.find("#city").val( old.find(".city").text() )
  target.find("#phone").val( old.find(".phone").text() )
}

$(function() {
  $("input[name='shipmentOption']").click(shipmentSelected);
  $("#fill_address").click(fillAddress);
});
