require 'spec_helper'

describe "Basket totals" do
  it "creates proper quantities" do
    basket = create :basket_3_items
  end

  it "calculates tax for 2" do
    basket = create :basket_2_items
    expect(basket.items.length).to be 2
    taxes = basket.taxes
    expect(taxes[10.0]).to eq 2.0
    expect(taxes[20.0]).to eq 8.0
  end
  it "updates total on add" do
    basket = create :basket_2_items
    expect(basket.total_price).to eq 60.0
    expect(basket.total_tax).to eq 10.0
  end
  it "updates total on destroy" do
    basket = create :basket_2_items
    basket.items.delete basket.items.last
    basket.save!
    expect(basket.total_price).to eq 20.0
    expect(basket.total_tax).to eq 2.0
  end
  it "destroys" do
    basket = create :basket_2_items
    basket.items.delete basket.items.last
    basket.save!
    expect(basket.items.length).to be  1
  end
end
