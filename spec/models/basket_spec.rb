require 'spec_helper'

describe Basket do
  it "factory is ok" do
    b = Basket.new attributes_for :basket
    b.save.should be true
  end
  it "adds a product and updates the quantity" do
    b = create :basket
    b.items.length.should be 0
    product = create :product
    b.add_product product
    b.items.length.should be 1
    b.items.first.quantity.should be 1
    b.add_product product
    b.items.length.should be 1
    b.items.first.quantity.should be 2
    b.add_product nil
    b.items.first.quantity.should be 2
  end
  it "calculates tax" do
    basket = create :basket
    basket.items << create( :item2)
    basket.items << create(:item22)
    basket.items.length.should be 2
    taxes = basket.taxes
    taxes[5.0].should be 1.0
    taxes[10.0].should be 4.0
  end
end
