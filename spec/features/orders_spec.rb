require 'spec_helper'

describe "Orders" do
  before(:each) do
    sign_in
  end
  it "lists orders" do
    visit_path orders_path
  end
  it "should render" do
    order = create :order
    visit_path order_path order
  end
  it "creates order from basket" do
    basket = create(:basket_with_item)
    visit_path edit_basket_path(basket)
    find(".make_order").click
    ensure_path order_path(basket.reload.kori)
  end
  it "orders a order" do
    order = create(:order_ordered)
    visit_path order_path(order)
    find(".pay_now").click
  end
  it "inventories a order" do
    order = create(:order_paid)
    visit_path order_path(order)
    start = order.basket.items.first.product.inventory
    find(".ship_now").click
#    expect(order.basket.items.first.product.inventory).to be order.basket.items.first.quantity
  end
end
