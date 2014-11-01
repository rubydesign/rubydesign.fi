require 'spec_helper'

describe Basket do
  it "creates basket" do
    basket = build :basket
    expect(basket.save).to be  true
    expect(basket.total_tax).to eq(0.0)
    expect(basket.total_price).to eq(0.0)
  end
  it "adds a product" do
    basket = create :basket
    expect(basket.items.length).to be  0
    product = create :product
    basket.add_product product
    expect(basket.items.length).to be  1
    expect(basket.items.first.quantity).to be  1
  end
  it "adds 2 products without duplication" do
    basket = create :basket
    prod =  create :product
    basket.add_product prod
    basket.add_product prod
    expect(basket.items.length).to be  1
    expect(basket.items.first.quantity).to be  2
  end
  it "adds nil" do
    basket = create :basket
    basket.add_product nil
    expect(basket.items.length).to be  0
  end
end
