require 'spec_helper'

describe "ProductGroups" do
  describe "/product_groups" do
    it "lists product groups" do
      visit product_groups_path
      page.should_not have_css(".translation_missing")
    end
  end
  describe "/product_groups/new" do
    it "creates a new group" do
      visit new_product_group_path
      page.should_not have_css(".translation_missing")
    end
  end
end
