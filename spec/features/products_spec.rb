require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "lists products" do
      visit products_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
end
