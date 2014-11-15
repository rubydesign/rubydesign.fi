require 'spec_helper'

describe "Basket totals" do
  it "creates proper quantities" do
    basket = create :basket_3_items
  end

  it "calculates tax for 2" do
    basket = create :basket_2_items
    expect(basket.items.length).to be 2
    taxes = basket.taxes
    expect(taxes.values.first.round(2)).to eq  basket.total_tax.round(2)
  end
  it "updates total on add" do
    basket = create :basket_2_items
    items = basket.items
    total = items.first.price * items.first.quantity + items.last.price * items.last.quantity
    expect(basket.total_price).to eq total
    # assume the same tax (as per factory)
    expect(basket.total_tax).to eq total * items.first.tax / 100
  end
  it "updates total on destroy" do
    basket = create :basket_2_items
    total = basket.items.first.price
    tax = total * basket.items.first.tax / 100
    basket.items.delete basket.items.last
    basket.save!
    expect(basket.total_price).to eq total
    expect(basket.total_tax).to eq tax.to_f
  end
  it "destroys" do
    basket = create :basket_2_items
    basket.items.delete basket.items.last
    basket.save!
    expect(basket.items.length).to be  1
  end
end
