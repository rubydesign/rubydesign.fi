require 'spec_helper'

describe "Shops" do
  describe "GET /prod" do
    it "get something" do
      p = create :product
      g = create :category
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit shop_product(:link => p.link)
      status_code.should be(200)
    end
  end
end
