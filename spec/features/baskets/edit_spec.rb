require 'spec_helper'

# lots of edit possibilities for price/quantity and items

describe "edit baskets" do
  before :each do
    sign_in
  end
  it "renders items" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    td = find(".table").first(".name")
    expect(td).to have_content(basket.items.first.name)
  end
  it "deletes item" do
    basket = create :basket_with_item
    visit_path edit_basket_path(basket)
    name = basket.items.first.name
    within(".table") {  first('a', :text => I18n.t(:delete)).click }
    expect{ find(".table").find(".name" , :minimum => 1) }.to raise_error
    expect(page).not_to have_content(name )
  end
  it "renders 2 items with amount and total" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    td = find(".table").first(".name")
    expect(td).to have_content(basket.items.first.name)
    expect(find(".count").text).to include( I18n.t(:count))
    expect(find(".total").text).to include( basket.total_price.round(2).to_s.sub(".",",")) # TODO remove the format hack 
  end
end
