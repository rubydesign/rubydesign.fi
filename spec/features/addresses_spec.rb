require 'spec_helper'

describe "Addresses" do
  describe "GET /addresses" do
    it "lists addresses" do
      visit addresses_path
      page.should_not have_css(".translation_missing")
    end
  end
end
