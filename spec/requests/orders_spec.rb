require 'spec_helper'

describe "Orders" do
  describe "GET /orders" do
    it "lists orders" do
      visit orders_path
      page.should_not have_css(".translation_missing")
    end
  end
  describe "GET /orders/new" do
    it "creates a new order" do
      visit new_order_path
      page.should_not have_css(".translation_missing")
    end
  end
end
