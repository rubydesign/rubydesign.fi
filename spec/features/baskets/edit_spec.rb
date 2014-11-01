require 'spec_helper'

describe "edit baskets" do
  before :each do
    sign_in
  end
  it "renders item too" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    td = find(".table").find(".name")
    expect(td).to have_content(@basket.items.first.name)
  end
  it "deletes item" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    name = basket.items.first.name
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
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    click_on I18n.t(:make_purchase)
    expect(find("h2")).to have_content(I18n.t(:purchase))
  end
  it "finds print link" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    expect(page).to have_content(I18n.t(:print_order))
    expect(find(".print_order")).to have_content(I18n.t(:print_order))
  end
end
