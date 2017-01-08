

describe "Basket totals" do
  let(:basket) { create :basket_2_items }
  
  it "calculates tax for 2" do
    expect(basket.items.length).to be 2
    taxes = basket.taxes
    expect(taxes.values.first.round(2)).to eq  basket.total_tax.to_f.round(2)
    expect(taxes.values.length).to eq  1
  end
  it "calculates total tax right" do
    expect(basket.items.first.product.price).to eq 10.0
    expect(basket.items.first.product.tax).to eq 10.0
    expect(basket.total_tax).to eq 2.73
  end
  it "calculates tax hash" do
    expect(basket.taxes.length).to eq 1
    expect(basket.taxes.keys.first).to eq 10.0
    expect(basket.taxes.values.first).to eq 2.7273
  end
end
