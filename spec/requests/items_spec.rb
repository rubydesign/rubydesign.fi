require 'request_helper'

describe "Items" do
  describe "GET /items" do
    it "lists items" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit items_path
      page.should_not have_css(".translation_missing")
    end
  end
  describe "GET /item/new" do
    it "creates a new item" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit new_item_path
      page.should_not have_css(".translation_missing")
    end
  end
end
