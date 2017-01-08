

# lots of edit possibilities for price/quantity and items

describe "edit baskets" do
  before :each do
    sign_in
  end
  it "deletes item" do
    basket = create :basket_with_item
    visit_path edit_basket_path(basket)
    name = basket.items.first.name
    within(".table") {  first('a', :text => I18n.t(:delete)).click }
    expect{ find(".table").find(".name" , :minimum => 1) }.to raise_error Capybara::ElementNotFound
    expect(page).not_to have_content(name )
  end
  it "add quantity to item" do
    basket = create :basket_with_item
    visit_path edit_basket_path(basket)
    expect(find( "//table #basket_items_attributes_0_quantity").value).to eq basket.items.first.quantity.to_s
    fill_in "basket_items_attributes_0_quantity" , :with => 2
    find(".commit").click()
    td = find("//table #basket_items_attributes_0_quantity")
    expect(td.value).to eq("2")
  end
  it "change item price" do
    basket = create :basket_with_item
    visit_path edit_basket_path(basket)
    expect(find( "//table #basket_items_attributes_0_price").value).to eq basket.items.first.price.to_s
    fill_in "basket_items_attributes_0_price" , :with => 20
    find(".commit").click()
    td = find("//table #basket_items_attributes_0_price")
    expect(td.value).to eq("20.0")
  end
  it "discounts basket" do
    basket = create :basket_with_item
    total = basket.total_price
    visit office.discount_basket_path(basket , :discount => "10")
    expect_basket_total total * 0.9
  end
  it "zeros basket" do
    basket = create :basket_with_item
    visit zero_basket_path(basket)
    expect_basket_total 0.0
  end
  it "discounts item" do
    basket = create :basket_2_items
    total = basket.total_price - basket.items.first.price*0.1
    visit discount_basket_path(basket , :discount => "10" , :item => basket.items.first)
    expect_basket_total total
    td = find("//table #basket_items_attributes_0_price")
    expect(td.value).to eq((basket.items.first.price*0.9).round(2).to_s)
  end

end
