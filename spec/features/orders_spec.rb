require 'spec_helper'

describe "Orders" do
  describe "GET /orders" do
    it "lists orders" do
      visit orders_path
      status_code.should be 200
      translates page
    end
  end
  describe "GET /orders/new" do
    it "creates a new order" do
      visit new_order_path
      status_code.should be 200
      translates page
    end
  end
  describe "edit order" do
    it "should render" do
      order = create :order
      visit edit_order_path order
      status_code.should be 200
      translates page
    end
  end
  describe "show order" do
    it "should render" do
      order = create :order
      visit order_path order
      status_code.should be 200
      translates page
    end
  end
end
