require 'spec_helper'

describe "Buckets" do
  describe "GET /buckets" do
    it "lists buckets" do
      visit buckets_path
      page.should_not have_css(".translation_missing")
    end
  end
end
