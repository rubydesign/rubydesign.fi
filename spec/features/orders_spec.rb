require 'spec_helper'

describe "Orders" do
  before(:each) do
    sign_in
  end
  it "lists orders" do
    visit_path orders_path
  end
  it "creates a new order" do
    visit_path new_order_path
  end
  it "should render" do
    order = create :order
    visit_path order_path order
  end
end
