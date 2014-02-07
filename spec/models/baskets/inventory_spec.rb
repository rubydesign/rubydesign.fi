require 'spec_helper'

describe "Basket inventory" do
  before(:each) do
    @basket = create :basket
    @basket.items << create( :item2)
    @basket.items << create(:item22)
    @basket.save!
  end
  it "receives ok" do
    p1 = @basket.items.first.product.inventory
    p2 = @basket.items.last.product.inventory
    @basket.receive!
    @basket.reload    
    @basket.items.first.product.inventory.should be p1 + 1
    @basket.items.last.product.inventory.should be p2 + 2
  end
  it "deducts ok" do
    p1 = @basket.items.first.product.inventory
    p2 = @basket.items.last.product.inventory
    @basket.deduct!
    @basket.reload    
    @basket.items.first.product.inventory.should be p1 - 1
    @basket.items.last.product.inventory.should be p2 - 2
  end
end
