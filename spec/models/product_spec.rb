require 'spec_helper'

describe Product do
  it "factory is ok" do
    pro = build :product
    expect(pro.save).to be true
  end
  it "defaults work" do
    pro = create :product
    expect(pro.tax).not_to be nil
    expect(pro.link).not_to be nil
    expect(pro.cost).not_to be nil
    expect(pro.ean).not_to be nil
    expect(pro.scode).not_to be nil
  end
  it "validates a name" do
    pro = Product.new
    expect(pro.save).to be  false
  end
  it "deletes" do
    pro = create :product
    on = Product.find pro.id
    expect(on.id).to be  pro.id
    on.delete
    expect(on.save).to be  true
    on = Product.where(:id => pro.id).first
    expect(on).to be  nil
  end
end
