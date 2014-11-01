require 'spec_helper'

describe Item do
  it "saves factory" do
    i = build :item
    expect(i.save).to be true
  end
  it "has quantity" do
    item = create :item
    expect(item.quantity).to be 1
    item2 = create :item22
    expect(item2.quantity).to be 2
    expect(item.name).not_to eq item2.name
  end

  it "calcualtes taxes" do
    [create(:item) , create(:item2) , create(:item22)].each do |c|
      expect(c.tax_amount).to be ((c.tax * c.price*c.quantity) / 100.0).round(2)
    end
  end
  it "calcualtes total" do
    [create(:item) , create(:item2) , create(:item22)].each do |c|
      expect(c.total).to be (c.quantity * c.price).round(2)
    end
  end
  it "has products" do
    [create(:item) , create(:item2) , create(:item22)].each do |c|
      expect(c.product.full_name).not_to be blank?
      expect(c.product.price).not_to be nil
      expect(c.product.tax).not_to be nil
    end
  end
end