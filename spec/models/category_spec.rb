

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
    expect(cat.link).to eq  "pois"
    expect(Category.where(:id => cat.id).first).to be  nil
    expect(Category.unscoped.find(cat.id)).not_to be nil
  end

end
