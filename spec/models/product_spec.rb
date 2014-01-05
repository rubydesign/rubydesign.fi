require 'spec_helper'

describe Product do
  it "factory is ok" do 
    pro = build :product
    pro.save.should be true
  end
  it "defaults work" do 
    pro = create :product
    pro.tax.should_not be nil
    pro.link.should_not be nil
    pro.cost.should_not be nil
    pro.ean.should_not be nil
    pro.scode.should_not be nil  
  end
  it "validates a name" do 
    pro = Product.new
    pro.save.should be false
  end
end
