require 'spec_helper'

describe "Suppliers" do
  before(:each) do
    sign_in
  end
  it "lists suppliers" do
    visit_path suppliers_path
  end
end
