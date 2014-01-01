require 'spec_helper'

describe Basket do
  it "factory is ok" do 
    b = Basket.new FactoryGirl.attributes_for :basket
    b.save.should be true
  end
end
