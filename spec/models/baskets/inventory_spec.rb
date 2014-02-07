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
  it "locks after receive" do
    @basket.receive!
    @basket.locked.should_not be nil
    expect { @basket.receive! }.to raise_error 
  end
  it "locks after deduct" do
    @basket.deduct!
    @basket.locked.should_not be nil
    expect { @basket.deduct! }.to raise_error 
  end
end
