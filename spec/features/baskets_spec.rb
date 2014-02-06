require 'spec_helper'

describe "Baskets" do
  before(:each) do
    sign_in
  end
  describe "GET /baskets" do
    it "lists baskets" do
      visit_path baskets_path
    end
  end
  describe "new baskets" do
    before(:each) do 
      visit_path new_basket_path
    end
    it "renders" do
    end
    it "adds product" do
      ean = "123456Z"
      p = create :product , :ean => ean
      within ".ean_form" do
        fill_in "ean" , :with => "#{ean}"
        click_on I18n.t(:search)
      end
      td = find(".table").find(".name")
      td.should have_content(p.name)
    end
  end
  describe "edit baskets" do
    before :each do
      sign_in
      @basket = create :basket
      @basket.items << create(:item22)
      @basket.save!
      visit_path basket_path(@basket)
    end
    it "renders item too" do
      td = find(".table").find(".name")
      td.should have_content(@basket.items.first.name)
    end
    it "deletes item" do
      name = @basket.items.first.name
      click_link I18n.t(:delete)
      td = find(".table").find(".name")
      td.should_not have_content(name )
    end
    it "goes to purchase" do
      click_on I18n.t(:make_purchase)
      find("h2").should have_content(I18n.t(:purchase))
    end
    it "finds print link" do
      page.should have_content(I18n.t(:print_order))
      find(".print_order").should have_content(I18n.t(:print_order))
    end
  end
end
