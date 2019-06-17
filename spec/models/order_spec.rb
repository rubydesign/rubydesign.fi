

describe Order do
  let(:order) { create :order }
  let(:shipped_order) { create :order_shipped }
  let(:ordered_order) { create :order_ordered }

  it "factory is ok" do
    o = build :order
    ok = o.save
    expect(ok).to be true
  end

  it "doesnt save a blank order" do
    expect(Order.new.save).to eq false
  end

  it "creates orders without ref numbers" do
    expect(order.order_number).to be nil
  end

  it "creates ordered orders with ref numbers" do
    expect(ordered_order.number).not_to be nil
  end

  it "returns id if no number" do
    expect(order.id_number). to eq "1"
  end
  it "returns order_number if number" do
    expect(ordered_order.id_number). to eq "R201930000"
  end

  it "ups the number on 2 consecutive orders" do
    numm = ordered_order.order_number
    num2 = order.generate_order_number
    expect(num2).to eq numm + 1
  end

  it "returns a reference number" do
    expect(shipped_order.viite.length).to be 10
  end

  it "doesnt save order with just mail" do
    expect(Order.new(:email => "torsten@villataika.fi").save).to eq false
  end

  it "verification works" do
    o = Order.new attributes_for :order
    ok = o.save
    expect(ok).to be true
  end

  it "creates ok" do
    expect(order.basket.locked?).to eq false
  end

  it "creates shipped order" do
    o = shipped_order
    expect(o.basket.locked?).to eq true
  end

  it "calculates total tax" do
    expect(order.basket.items.length).to eq 1
    expect(order.total_tax).to eq 0.91
  end

  it "calculates tax per rate" do
    expect(order.taxes.length).to eq 1
    expect(order.taxes.first).to eq [10.0 , 0.9091]
  end
  it "handles invalid shipment info" do
    expect(shipped_order.shipment_type = :invalid).not_to be nil
  end
  it "setting invalid shipment info doesn change the info" do
    info = shipped_order.shipment_type
    shipped_order.shipment_type = :invalid
    expect(shipped_order.shipment_type).to eq info
  end
  it "adds shipping tax to taxes" do
    expect(shipped_order.taxes.length).to eq 2
    expect(shipped_order.taxes.first).to eq [10.0 , 0.9091]
    expect(shipped_order.taxes[20.0]).to eq 1.6667
  end

  it "calculates total tax with shipping" do
    expect(shipped_order.total_tax).to eq 2.5767
  end

  it "cancels after shipping" do
    expect(shipped_order.cancel!).to be true
  end

end
