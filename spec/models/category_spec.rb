require 'spec_helper'

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
end
