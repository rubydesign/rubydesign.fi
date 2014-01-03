require 'spec_helper'

describe Basket do
  it "factory is ok" do 
    b = Basket.new attributes_for :basket
    b.save.should be true
  end
  it "validates" do 
    b = Basket.new 
    b.save.should be false
  end
end
