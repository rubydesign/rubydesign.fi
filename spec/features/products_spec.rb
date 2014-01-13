require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "lists products" do
      visit products_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
  describe "new product" do
    it "should render" do
      visit new_product_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
  describe "edit product" do
    it "should render" do
      product = create :product
      visit edit_product_path product
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
end
