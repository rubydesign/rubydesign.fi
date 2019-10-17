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
    expect(pro.supplier).not_to be nil
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

end
