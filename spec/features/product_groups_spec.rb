require 'spec_helper'

describe "ProductGroups" do
  describe "GET /product_groups" do
    it "lists product groups" do
      visit product_groups_path
      page.should_not have_css(".translation_missing")
    end
  end
end
