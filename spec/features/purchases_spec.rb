require 'spec_helper'

describe "Purchases" do
  describe "GET /purchases" do
    it "lists purchases" do
      visit purchases_path
      should_translate page
    end
  end
  it "creates a new purchases" do
    visit new_purchase_path
    should_translate page
  end
  it "shows" do
    @purchase = create(:purchase)
    visit purchase_path(@purchase)
    should_translate page
  end
end
