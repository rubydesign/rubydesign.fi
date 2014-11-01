require 'spec_helper'

describe "Shops" do
  describe "GET /prod" do
    it "get something" do
      p = create :product , :online => true
      g = create :category
      visit_path shop_product_path(:link => p.link)
      expect(status_code).to be(200)
    end

    it "redirects for wrong input" do
      visit shop_product_path(:link => "nonexistant")
      expect(page.current_path).to include "group"
      expect(status_code).to be(200)
    end
  end
end
