describe Product do
  it "factory is ok" do
    pro = build :product
    expect(pro.save).to be true
  end
  it "default factory produces values" do
    pro = create :product
    expect(pro.tax).not_to be nil
    expect(pro.link).not_to be nil
    expect(pro.cost).not_to be nil
    expect(pro.ean).not_to be nil
    expect(pro.scode).not_to be nil
    expect(pro.inventory). to be > 0
    expect(pro.type).to be :product
    expect(pro.supplier).not_to be nil
  end

  it "default factory product and not items" do
    pro = create :product
    expect(pro.line?).to be false
    expect(pro.product_item?).to be false
  end

  it "factory creates product lines ok" do
    line = create :product_line
    expect(line.line?).to be true
    expect(line.type).to be :product_line
    expect(line.products.first.line?).to be false
    expect(line.products.first.type).to be :product_item
    expect(line.products.first.product_item?).to be true
  end

  it "validates a name" do
    pro = Product.new
    expect(pro.save).to be  false
  end

  it "validates a name" do
    pro = Product.new
    expect(pro.save).to be  false
  end

  it "deletes if inventory is 0" do
    pro = create :product
    pro.inventory = 0
    pro.delete
    expect(pro.save).to be  true
    expect(Product.where(:id => pro.id).first).to be  nil
    expect(Product.unscoped.find(pro.id)).not_to be nil
  end

  it "does not delete if there is inventory" do
    pro = create :product
    pro.delete
    expect(pro.save).to be false
  end

  it "removes ean if make line" do
    line = create :product , :ean => "1234"
    item = line.new_product_item
    item.name = "my unique name"
    expect(item.save).to be true
    expect(item.link).to be_blank
    expect(line.reload.ean).to be_blank
  end
  it "removes link for items" do
    line = create :product_line
    item = line.products.first
    expect(item.link).to be_blank
    item.link = item.name
    expect(item.save).to be true
    expect(item.link).to be_blank
  end
end
