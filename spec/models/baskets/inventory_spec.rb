require 'spec_helper'

describe "Basket inventory" do
  it "receives ok" do
    basket = create :basket_2_items
    p1 = basket.items.first.product.inventory
    p2 = basket.items.last.product.inventory
    basket.receive!
    basket.reload
    expect(basket.items.first.product.inventory).to eq  p1 + basket.items.first.quantity
    expect(basket.items.last.product.inventory).to eq  p2 + basket.items.last.quantity
  end
  it "deducts ok" do
    basket = create :basket_2_items
    inv1 = basket.items.first.product.inventory - basket.items.first.quantity
    inv2 = basket.items.last.product.inventory - basket.items.last.quantity
    expect(basket.deduct!).to be 3
    basket.reload
    expect(basket.items.first.product.inventory).to eq inv1
    expect(basket.items.last.product.inventory).to eq inv2
  end
  it "locks after receive" do
    basket = create :basket_2_items
    expect(basket.receive!).to be 3
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
