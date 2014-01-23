require 'spec_helper'

describe Item do
  it "saves factory" do
    i = Item.new attributes_for :item
    i.save.should be true
  end
  it "calcualtes taxes" do
    [create(:item) , create(:item2) , create(:item22)].each do |c|
      c.tax_amount.should be ((c.tax * c.price*c.quantity) / 100.0).round(2)
    end
  end
  it "calcualtes total" do
    [create(:item) , create(:item2) , create(:item22)].each do |c|
      c.total.should be (c.quantity * c.price).round(2)
    end
  end
end