require 'spec_helper'

describe "Orders" do
  before(:each) do
    sign_in
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
  it "ships an order" do
    order = create(:order_ordered)
    visit_path order_path(order)
    find(".shipment_type").click
    ensure_path shipment_order_path(order)
  end
  it "pays an order" do
    order = create(:order_ordered)
    visit_path order_path(order)
    find(".pay_now").click
  end
  it "cant pay twice" do
    order = create(:order_paid)
    visit_path order_path(order)
    expect {find(".pay_now").click}.to raise_error Capybara::ElementNotFound
  end
  it "can edit basket of ordered order" do
    order = create(:order_ordered)
    visit_path order_path(order)
    find(".edit_basket").click
    ensure_path edit_basket_path(order.basket)
  end
end
