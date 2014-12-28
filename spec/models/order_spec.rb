require 'spec_helper'

describe Order do
  let(:order) { create :order }
  let(:shipped_order) { create :order_shipped }

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
    order
  end

  it "calculates total tax" do
    expect(order.basket.items.length).to eq 1
    expect(order.total_tax).to eq 0.91
  end

  it "calculates tax per rate" do
    expect(order.taxes.length).to eq 1
    expect(order.taxes.first).to eq [10.0 , 0.9091]
  end

  it "adds shipping tax to taxes" do
    expect(shipped_order.taxes.length).to eq 2
    expect(shipped_order.taxes.first).to eq [10.0 , 0.9091]
    expect(shipped_order.taxes[20.0]).to eq 1.6667
  end

  it "calculates total tax with shipping" do
    expect(shipped_order.total_tax).to eq 2.5767
  end
end
