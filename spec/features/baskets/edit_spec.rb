require 'spec_helper'

describe "edit baskets" do
  before :each do
    sign_in
    @basket = create :basket
    @basket.items << create(:item22)
    @basket.save!
    visit_path edit_basket_path(@basket)
  end
  it "renders item too" do
    td = find(".table").find(".name")
    td.should have_content(@basket.items.first.name)
  end
  it "deletes item" do
    name = @basket.items.first.name
    within(".table") do
      click_link I18n.t(:delete)
    end
    within(".table") do
      click_link I18n.t(:delete)
    end
    expect{ find(".table").find(".name") }.to raise_error
    expect(page).not_to have_content(name )
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
