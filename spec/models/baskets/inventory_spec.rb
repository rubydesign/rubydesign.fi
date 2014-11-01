require 'spec_helper'

describe "Basket inventory" do
  it "receives ok" do
    basket = create :basket_2_items
    p1 = basket.items.first.product.inventory
    p2 = basket.items.last.product.inventory
    expect(p1).to be > 2
    expect(p2).to be > 2
    basket.receive!
    basket.reload
    expect(basket.items.first.product.inventory).to eq  p1 + 1
    expect(basket.items.last.product.inventory).to eq  p2 + 2
  end
  it "deducts ok" do
    basket = create :basket_2_items
    p1 = basket.items.first.product.inventory
    p2 = basket.items.last.product.inventory
    basket.deduct!
    basket.reload
    expect(basket.items.first.product.inventory).to eq  (p1 - 1)
    expect(basket.items.last.product.inventory).to eq  (p2 - 2)
  end
  it "locks after receive" do
    basket = create :basket_2_items
    basket.receive!
    expect(basket.locked).not_to be nil
    expect { basket.receive! }.to raise_error 
  end
  it "locks after deduct" do
    basket = create :basket_2_items
    basket.deduct!
    expect(basket.locked).not_to be nil
    expect { basket.deduct! }.to raise_error 
  end
end
