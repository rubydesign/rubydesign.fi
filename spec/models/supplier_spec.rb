require 'spec_helper'

describe Supplier do
  it "factory is ok" do 
    s = Supplier.new FactoryGirl.attributes_for :supplier
    s.save.should be true
  end
end
