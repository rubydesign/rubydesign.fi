

describe "Purchases" do
  before(:each) do
    sign_in
  end
  it "lists purchases" do
    visit_path purchases_path
  end
  it "shows" do
    purchase = create(:purchase)
    visit_path purchase_path(purchase)
  end
  it "orders a purchase" do
    purchase = create(:purchase)
    visit_path purchase_path(purchase)
    find(".order_link").click
  end
  it "orders a purchase" do
    purchase = create(:purchase_ordered)
    visit_path purchase_path(purchase)
    start = purchase.basket.items.first.product.inventory
    find(".receive_link").click
    expect(purchase.basket.items.first.product.inventory).to be start + purchase.basket.items.first.quantity
  end
  it "inventories a purchase" do
    purchase = create(:purchase_ordered)
    start = purchase.basket.items.first.product.inventory
    visit_path purchase_path(purchase)
    find(".inventory_link").click
    expect(purchase.basket.items.first.product.inventory).to be purchase.basket.items.first.quantity
  end
end
