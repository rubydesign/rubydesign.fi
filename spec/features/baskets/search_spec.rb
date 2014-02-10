require 'spec_helper'

describe "Basket buttons" do
  before(:each) do
    sign_in
  end
  describe "GET /baskets" do
    it "lists baskets" do
      visit_path baskets_path
    end
  end
end