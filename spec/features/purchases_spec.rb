require 'spec_helper'

describe "Purchases" do
  describe "GET /purchases" do
    it "lists purchases" do
      visit purchases_path
      status_code.should be 200
      translates page
    end
  end
  it "creates a new purchases" do
    visit new_purchase_path
    status_code.should be 200
    translates page
  end
  it "edit" do
    @purchase = create(:purchase)
    visit edit_purchase_path(@purchase)
    status_code.should be 200
    translates page
  end
  it "shows" do
    @purchase = create(:purchase)
    visit purchase_path(@purchase)
    status_code.should be 200
    translates page
  end
end
