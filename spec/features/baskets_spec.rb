require 'spec_helper'

describe "Baskets" do
  describe "GET /baskets" do
    it "lists baskets" do
      visit baskets_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
      page.should_not have_text("translation_missing")
    end
  end
  describe "new baskets" do
    it "should render" do
      visit new_basket_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
  describe "edit baskets" do
    it "should render" do
      basket = create :basket
      visit edit_basket_path basket
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
end
