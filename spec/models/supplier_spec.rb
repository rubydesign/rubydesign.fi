require 'spec_helper'

describe Supplier do
  it "factory is ok" do 
    s = build :supplier
    s.save.should be true
  end
#  it "invalid address" do 
#    s = build :supplier
#    s.save.should be false
#  end
end
