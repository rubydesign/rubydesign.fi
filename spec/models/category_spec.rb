

describe Category do
  it "validates a name" do
    pro = Category.new
    expect(pro.save).to be false
  end

  it "saves ok" do
    pro = Category.new  :name => "some name"
    expect(pro.save).to be true
  end

  it "factory works" do
    pro = build :category
    expect(pro.save).to be true
  end

  it "deletes " do
    cat = create :category
    expect(cat.delete.save).to be  true
    expect(Category.where(:id => cat.id).first).to be  nil
    expect(Category.unscoped.find(cat.id)).not_to be nil
  end

  it "deletes twice" do
    cat1 = create :category
    cat2 = create :category
    expect(cat1.delete.save).to be  true
    expect(cat2.delete.save).to be  true
    expect(Category.where(:id => cat1.id).first).to be  nil
    expect(Category.where(:id => cat2.id).first).to be  nil
  end
end
