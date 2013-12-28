require 'spec_helper'

describe "Suppliers" do
  describe "GET /suppliers" do
    it "lists suppliers" do
      visit suppliers_path
      page.should_not have_css(".translation_missing")
    end
  end
end
