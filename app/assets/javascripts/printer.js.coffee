if gon.order_id
  jQuery.ajax(url: "/orders/" + gon.order_id + "/button_list.html").done (html) ->
    $(".order_show_back").append html

if gon.product_id
  jQuery.ajax(url: "/products/" + gon.product_id + "/barcode_button.html").done (html) ->
    $(".product_show_row_end").append html

if gon.basket_id
  jQuery.ajax(url: "/baskets/" + gon.basket_id + "/button_list.html").done (html) ->
    $(".basket_show_end").append html

if gon.purchase_id
  $(document).on "ready" , ->
    $(".purchase_show_last").append '<a class="btn btn-primary" href="/purchases/' + gon.purchase_id + '/invoice">Print Invoice</a>'

