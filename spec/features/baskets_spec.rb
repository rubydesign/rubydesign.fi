require 'spec_helper'

describe "Baskets" do
  describe "GET /baskets" do
    it "lists baskets" do
      visit baskets_path
      should_translate page
      page.should_not have_text("translation_missing")
    end
  end
  describe "new baskets" do
    it "should render" do
      visit new_basket_path
      should_translate page
    end
  end
  describe "edit baskets" do
    it "should render" do
      basket = create :basket
      visit edit_basket_path basket
      should_translate page
    end
  end
end
