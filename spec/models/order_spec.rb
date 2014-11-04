require 'spec_helper'

describe Order do
  it "factory is ok" do
    o = build :order
    ok = o.save
    expect(ok).to be true
  end

  it "verification works" do
    o = Order.new attributes_for :order
    ok = o.save
    expect(ok).to be true
  end

  it "creates ok" do
    o1 = create :order
  end
end
