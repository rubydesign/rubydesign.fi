
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_self

function shipmentSelected(){
  val = $("input[name='order[shipment_type]']:checked").data("price");
  ship = parseFloat(val);
  val = $("#basket_total").text();
  basket = parseFloat(val);
  $("#shipping_cost").text( ship.toFixed(2) );
  $("#order_total").text( (ship + basket).toFixed(2) );
}

function fillAddress(){
  old = $("#previous_address");
  target = $("#address_form");
  target.find("#order_name").val( old.find(".name").text() )
  target.find("#order_street").val( old.find(".street").text() )
  target.find("#order_city").val( old.find(".city").text() )
  target.find("#order_phone").val( old.find(".phone").text() )
}

$(function() {
  $("input[name='order[shipment_type]']").click(shipmentSelected);
  $("#fill_address").click(fillAddress);
});
