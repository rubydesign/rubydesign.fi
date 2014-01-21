require 'spec_helper'

describe "Baskets" do
  describe "GET /baskets" do
    it "lists baskets" do
      visit baskets_path
      should_translate page
    end
  end
  describe "new baskets" do
    before(:each){visit new_basket_path}
    it "renders" do
      should_translate page
    end
    it "adds product" do
      ean = "123456Z"
      p = create :product , :ean => ean
      fill_in "ean" , :with => "#{ean}\n"
      click_on ".ean_button"
      td = find(".table").find(".name")
      td.content.should_be p.name
    end
  end
  describe "edit baskets" do
    it "renders" do
      basket = create :basket
      visit edit_basket_path basket
      should_translate page
    end
  end
end
