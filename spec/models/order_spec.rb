require 'spec_helper'

describe Order do
  it "factory is ok" do 
    o = Order.new FactoryGirl.attributes_for :order
    o.save.should be true
  end
end
