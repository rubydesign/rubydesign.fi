require 'spec_helper'

describe Supplier do
  it "factory is ok" do 
    s = build :supplier
    s.address.new_record?.should be true
    s.save.should be true
  end
  it "invalid address" do 
    s = build :supplier
    s.address.first_name = ""
    s.save.should be false
  end
  it "invalid name" do 
    s = build :supplier , :name => ""
    s.save.should be false
  end
end
