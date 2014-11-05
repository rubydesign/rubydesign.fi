require 'spec_helper'

# lots of buttons appear and disapear, check that that all works

describe "Basket buttons" do
  before(:each) do 
    sign_in
  end
  it "should have back and update buttons" do
    visit_path new_basket_path
    expect(page).to have_content I18n.t(:back)
    find_button I18n.t("helpers.submit.update" , :model => I18n.t(:basket))
    find_link I18n.t(:new) + ' ' + I18n.t(:basket)
    find_link I18n.t(:destroy)
  end
  it "creates a new order" do
    basket = create :basket_with_item
    visit_path edit_basket_path basket
    expect(page).not_to have_content I18n.t(:to_order)
    click_link I18n.t(:checkout)
    expect(page).to have_content I18n.t("invoice.header")
  end
  it "goes to purchase" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    click_on I18n.t(:make_purchase)
    expect(find("h2")).to have_content(I18n.t(:purchase))
  end
  it "finds print link" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    expect(page).to have_content(I18n.t(:checkout))
    expect(find(".print_order")).to have_content(I18n.t(:checkout))
  end
end