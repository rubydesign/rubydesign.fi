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
      within ".ean_form" do
        fill_in "ean" , :with => "#{ean}"
        click_on "Search"
      end
      td = find(".table").find(".name")
      td.should have_content(p.name)
    end
  end
  describe "edit baskets" do
    before :each do 
      @basket = create :basket_with_item
      visit edit_basket_path @basket
      should_translate page
    end
    it "renders item too" do
      td = find(".table").find(".name")
      td.should have_content(@basket.items.first.product.name)
    end
    it "goes to order" do
      click_on I18n.t(:make_order)
      should_translate page
      find("h2").should have_content(I18n.t(:order))
    end
    it "goes to purchase" do
      click_on I18n.t(:make_purchase)
      should_translate page
      find("h2").should have_content(I18n.t(:purchase))
    end
    it "finds print link" do
      page.should have_content(I18n.t(:print_order))
      find(".print_order").should have_content(I18n.t(:print_order))
    end
  end
end
