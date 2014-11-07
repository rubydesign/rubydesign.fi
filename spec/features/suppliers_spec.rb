require 'spec_helper'

describe "Suppliers" do
  before(:each) do
    sign_in
  end
  it "lists suppliers" do
    create(:supplier)
    create(:supplier)
    visit_path suppliers_path
  end
  it "shows" do
    s = create(:supplier)
    visit_path supplier_path(s)
  end
  it "edits" do
    s = create(:supplier)
    visit_path edit_supplier_path(s)
  end
end
