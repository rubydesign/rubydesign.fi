require 'spec_helper'

describe "Purchases" do
  before(:each) do
    sign_in
  end
  it "lists purchases" do
    visit_path purchases_path
  end
  it "shows" do
    purchase = create(:purchase)
    visit_path purchase_path(purchase)
  end
end
