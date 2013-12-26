require 'spec_helper'

describe "Orders" do
  describe "GET /orders" do
    it "works!" do
      visit orders_path
      response.status.should be(200)
    end
  end
  describe "GET /orders/new" do
    it "works!" do
      visit new_order_path
      response.status.should be(200)
    end
  end
end
