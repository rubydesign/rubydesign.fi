require 'spec_helper'

describe Purchase do
  it "factory is ok" do
    p = Purchase.new attributes_for :purchase
    expect(p.save).to be  true
  end
end
