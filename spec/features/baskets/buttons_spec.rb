

# lots of buttons appear and disapear, check that that all works

describe "Basket buttons" do
  before(:each) do
    sign_in
  end
  it "should have back and update buttons" do
    visit_path new_basket_path
    find_button I18n.t("helpers.submit.update" , :model => I18n.t(:basket))
    find_link I18n.t(:new) + ' ' + I18n.t(:basket)
    find_link I18n.t(:destroy)
  end
  it "goes to purchase" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    click_on I18n.t(:make_purchase)
    expect(find("h2")).to have_content(I18n.t(:purchase))
  end
end
