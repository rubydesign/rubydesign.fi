require 'spec_helper'

describe "Orders" do
  before(:each) do
    sign_in
  end
  it "deduct inventory when shipping" do
    order = create(:order_paid)
    visit_path order_path(order)
    start = order.basket.items.first.product.inventory
    find(".ship_now").click
    expect(order.basket.reload.items.first.product.inventory).to equal start - order.basket.reload.items.first.quantity
  end
  it "not possible to ship twice" do
    order = create(:order_shipped)
    visit_path order_path(order)
    expect {find(".ship_now").click}.to raise_error Capybara::ElementNotFound
  end
end
