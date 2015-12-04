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
  it "can edit basket of paid order" do
    order = create(:order_ordered)
    visit_path order_path(order)
    find(".edit_basket").click
    ensure_path edit_basket_path(order.basket)
  end
  it "can cancel shipped order and edit" do
    order = create(:order_shipped)
    visit_path order_path(order)
    find(".cancel_order").click
    find(".edit_basket").click
    ensure_path edit_basket_path(order.basket)
  end
  it "can not edit basket of shipped order" do
    order = create(:order_paid)
    visit_path order_path(order)
    find(".ship_now").click
    expect {find(".edit_basket").click}.to raise_error Capybara::ElementNotFound
  end
  it  "allows shipment info to be changed" do
    address = { :name => "Markus Janhunen" , :street => "123 my street", :city => "123 my town" , :phone => "0400404"}
    order = create(:order_paid)
    visit_path shipment_order_path(order)
    address.each do |atrr, value|
      fill_in("order_#{atrr}" , :with => value)
    end
    find("#make_order").click
    ensure_path order_path(order)
    order.reload
    address.each do |atrr, value|
      expect(order.send atrr).to eq value
    end
  end
end
