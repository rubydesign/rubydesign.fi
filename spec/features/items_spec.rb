require 'request_helper'

describe "Items" do
  describe "GET /items" do
    it "lists items" do
      visit items_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
  describe "GET /item/new" do
    it "creates a new item" do
      visit new_item_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
end
