require 'spec_helper'

describe Address do
  it "factory is ok" do 
    a = FactoryGirl.build :address
    a.save.should be true
  end
  it "invalid doesnt save" do 
    a = FactoryGirl.build :address , first_name: ""
    a.save.should be false
  end
end
