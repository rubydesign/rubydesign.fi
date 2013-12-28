require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "lists products" do
      get products_path
      page.should_not have_css(".translation_missing")
    end
  end
end
