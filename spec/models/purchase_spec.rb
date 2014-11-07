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
    expect(p.receive!).to be 1
  end
  it "doesn't receives twice" do
    p = create :purchase
    expect(p.receive!).to be 1
    expect{p.receive!}.to raise_error RuntimeError 
  end
  it "inventories ok" do
    p = create :purchase
    expect(p.inventory!).to be 1
  end
end
