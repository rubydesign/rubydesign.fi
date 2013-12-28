require 'spec_helper'

describe "Addresses" do
  describe "GET /addresses" do
    it "lists addresses" do
      visit addresses_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
end
