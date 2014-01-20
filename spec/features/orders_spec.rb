require 'spec_helper'

describe "Orders" do
  describe "GET /orders" do
    it "lists orders" do
      visit orders_path
      should_translate page
    end
  end
  describe "GET /orders/new" do
    it "creates a new order" do
      visit new_order_path
      should_translate page
    end
  end
  describe "edit order" do
    it "should render" do
      order = create :order
      visit edit_order_path order
      should_translate page
    end
  end
  describe "show order" do
    it "should render" do
      order = create :order
      visit order_path order
      should_translate page
    end
  end
end
