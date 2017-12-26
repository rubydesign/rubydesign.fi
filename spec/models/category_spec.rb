

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
    cat.delete
    expect(cat.save).to be  true
    expect(cat.link).to eq  "pois_1"
    expect(Category.where(:id => cat.id).first).to be  nil
    expect(Category.unscoped.find(cat.id)).not_to be nil
  end

  it "deletes twice" do
    cat1 = create :category
    cat2 = create :category
    cat1.delete
    cat2.delete
    expect(cat1.save).to be  true
    expect(cat2.save).to be  true
    expect(cat1.link).to start_with   "pois"
    expect(Category.where(:id => cat1.id).first).to be  nil
    expect(Category.where(:id => cat2.id).first).to be  nil
  end
end
