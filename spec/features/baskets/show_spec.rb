require 'spec_helper'

describe "edit basket screen, no editing" do
  before :each do
    sign_in
  end
  it "renders items" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    td = find(".table").first(".name")
    expect(td).to have_content(basket.items.first.name)
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
