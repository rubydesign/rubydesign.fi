describe "Purchases" do
  before(:each) do
    sign_in
  end
  context "simple" do
    before(:each) do
      @purchase = create(:purchase)
    end
    it "lists purchases" do
      visit_path purchases_path
    end
    it "shows" do
      visit_path purchase_path(@purchase)
      expect(page).to have_content I18n.t(:purchase)
    end
    it "allows creating for same supplier" do
      visit_path purchase_path(@purchase)
      find(".purchase_link").click
      expect(page).to have_content I18n.t(:purchase)
    end
    it "orders a purchase" do
      visit_path purchase_path(@purchase)
      find(".order_link").click
      expect(@purchase.reload.ordered_on).not_to be nil
    end
  end

  context "inventory" do
    it "receives a purchase" do
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
end
