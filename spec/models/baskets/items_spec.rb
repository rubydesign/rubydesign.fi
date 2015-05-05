require 'spec_helper'

describe "Basket totals" do
  let(:basket) { create :basket_2_items }

  it "creates proper quantities" do
    basket = create :basket_3_items
    expect(basket.items.length).to eq 3
  end
  it "updates total on add" do
    items = basket.items
    total = items.first.price * items.first.quantity + items.last.price * items.last.quantity
    expect(basket.total_price).to eq total
    # assume the same tax (as per factory)
    tax =  (total * basket.items.first.tax / ( 100.0 + basket.items.first.tax)).round(2)
    expect(basket.total_tax.to_f).to eq tax
  end
  it "updates total on destroy" do
    total = basket.items.first.price
    basket.items.delete basket.items.last
    basket.save!
    expect(basket.total_price).to eq total
  end
  it "destroys" do
    basket.items.delete basket.items.last
    basket.save!
    expect(basket.items.length).to be  1
  end
  it "zeros basket" do
    basket.zero_prices!
    expect(basket.total_price).to eq 0.0
  end
end
