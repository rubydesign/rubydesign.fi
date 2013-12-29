require 'spec_helper'

describe "Baskets" do
  describe "GET /baskets" do
    it "lists baskets" do
      visit baskets_path
      status_code.should be 200
      page.should_not have_css(".translation_missing")
    end
  end
end
