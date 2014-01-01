require 'spec_helper'

describe Purchase do
  it "factory is ok" do 
    p = Purchase.new FactoryGirl.attributes_for :purchase
    p.save.should be true
  end
end
