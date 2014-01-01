require 'spec_helper'

describe Address do
  it "factory is ok" do 
    a = Address.new FactoryGirl.attributes_for :address
    a.save.should be true
  end
end
