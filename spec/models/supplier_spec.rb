

describe Supplier do
  it "factory is ok" do
    s = build :supplier
    expect(s.save).to be true
  end
end
