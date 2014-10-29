
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_self

function shipmentSelected(){
  val = $("input[name='shipmentOption']:checked").val();
  ship = parseFloat(val.replace(",", "."));
  val = $("#basket_total").text();
  basket = parseFloat(val.replace(",", "."));
  $("#shipping_cost").text( ship.toFixed(2) );
  $("#order_total").text( (ship + basket).toFixed(2) );
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
