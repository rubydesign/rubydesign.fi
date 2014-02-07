require 'spec_helper'

describe Basket do
  before(:each) do
    @basket = create :basket
  end
  it "creates basket" do
    @basket = build :basket
    @basket.save.should be true
    expect(@basket.total_tax).to eq(0.0)
    expect(@basket.total_price).to eq(0.0)
  end
  it "adds a product" do
    @basket.items.length.should be 0
    product = create :product
    @basket.add_product product
    @basket.items.length.should be 1
    @basket.items.first.quantity.should be 1
  end
  it "adds 2 products without duplication" do
    prod =  create :product
    @basket.add_product prod
    @basket.add_product prod
    @basket.items.length.should be 1
    @basket.items.first.quantity.should be 2
  end
  it "adds nil" do
    @basket.add_product nil
    @basket.items.length.should be 0
  end
end
