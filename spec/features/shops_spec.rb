require 'spec_helper'

describe "Shops" do
  describe "GET /prod" do
    it "get something" do
      FactoryGirl.create :product
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit prod_path(:id => 1)
      status_code.should be(200)
    end
  end
end
