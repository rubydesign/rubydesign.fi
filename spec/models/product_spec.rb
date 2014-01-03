require 'spec_helper'

describe Product do
  it "validates a name" do 
    pro = Product.new
    pro.save.should be false
  end
  it "factory is ok" do 
    pro = Product.new attributes_for :product
    pro.save.should be true
  end
end
