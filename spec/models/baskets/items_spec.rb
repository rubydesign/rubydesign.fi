require 'spec_helper'

describe Basket do
  before(:each) do
    @basket = create :basket
  end
  describe "totals" do
    before(:each) do
      @basket.items << create( :item2)
      @basket.items << create(:item22)
      @basket.save!
      @basket.items.length.should be 2
    end
    it "calculates tax for 2" do
      @basket.items.length.should be 2
      taxes = @basket.taxes
      expect(taxes[10.0]).to eq 2.0
      expect(taxes[20.0]).to eq 8.0
    end
    it "updates total on add" do
      expect(@basket.total_price).to eq 60.0
      expect(@basket.total_tax).to eq 10.0
    end
    it "updates total on destroy" do
      @basket.items.delete @basket.items.last
      @basket.save!
      expect(@basket.total_price).to eq 20.0
      expect(@basket.total_tax).to eq 2.0
    end
    it "destroys" do
      @basket.items.delete @basket.items.last
      @basket.save!
      @basket.items.length.should be 1
    end
  end
end
