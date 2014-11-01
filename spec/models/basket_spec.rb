require 'spec_helper'

describe Basket do
  it "factory is ok" do
    b = build :basket
    expect(b.save).to be true
  end

end
