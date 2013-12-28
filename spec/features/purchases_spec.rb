require 'spec_helper'

describe "Purchases" do
  describe "GET /purchases" do
    it "lists purchases" do
      visit purchases_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
end
