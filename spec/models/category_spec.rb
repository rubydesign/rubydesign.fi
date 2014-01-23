require 'spec_helper'

describe Category do
  it "validates a name" do
    pro = Category.new
    pro.save.should be false
  end
end
