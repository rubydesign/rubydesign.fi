require 'spec_helper'

describe Item do
  it "factory is ok" do 
    i = Item.new FactoryGirl.attributes_for :item
    i.save.should be true
  end
end
