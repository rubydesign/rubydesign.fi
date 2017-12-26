

describe Supplier do
  it "factory is ok" do
    s = build :supplier
    expect(s.save).to be true
  end

  it "deletes " do
    sup = create :supplier
    expect(sup.delete.save).to be  true
    expect(Supplier.where(:id => sup.id).first).to be  nil
    expect(Supplier.unscoped.find(sup.id)).not_to be nil
  end

  it "deletes twice" do
    sup1 = create :supplier
    sup2 = create :supplier
    expect(sup1.delete.save).to be  true
    expect(sup2.delete.save).to be  true
    expect(Supplier.where(:id => sup1.id).first).to be  nil
    expect(Supplier.where(:id => sup2.id).first).to be  nil
  end

end
