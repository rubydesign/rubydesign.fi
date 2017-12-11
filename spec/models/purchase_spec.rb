describe Purchase do

  context "simple" do
    it "factory builds" do
      purchase = build :purchase
      expect(purchase.save).to be  true
    end
    it "orders ok" do
      purchase = create :purchase
      expect(purchase.order!).to be true
    end
  end
  context "inventory" do
    before(:each) do
      @purchase = create :purchase
    end
    it "receives ok" do
      expect(@purchase.receive!).to be @purchase.basket.items.first.quantity
    end
    it "doesn't receives twice" do
      expect(@purchase.receive!).to be @purchase.basket.items.first.quantity
      expect{@purchase.receive!}.to raise_error RuntimeError
    end
    it "inventories ok" do
      item = @purchase.basket.items.first
      diff = item.quantity - item.product.inventory
      expect(@purchase.inventory!).to be diff
    end
  end
end
