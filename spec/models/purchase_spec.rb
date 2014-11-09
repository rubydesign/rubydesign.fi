require 'spec_helper'

describe Purchase do
  it "factory is ok" do
    p = build :purchase
    expect(p.save).to be  true
  end
  it "orders ok" do
    p = create :purchase
    expect(p.order!).to be true
  end
  it "receives ok" do
    p = create :purchase
    expect(p.receive!).to be p.basket.items.first.quantity
  end
  it "doesn't receives twice" do
    p = create :purchase
    expect(p.receive!).to be p.basket.items.first.quantity
    expect{p.receive!}.to raise_error RuntimeError 
  end
  it "inventories ok" do
    p = create :purchase
    item = p.basket.items.first
    diff = item.quantity - item.product.inventory
    expect(p.inventory!).to be diff
  end
end
