require "spec_helper"

RSpec.describe OfficeClerk::Post do

  describe 'using the default weight-price table: [1 2 5 10 20] => [2 5 10 15 18]' do
    context '.handling fee' do
      it 'gives handling fee plus min price with defaults and 0 items' do
        basket = create :basket
        result = price_for_basket(basket , :handling_fee => 10)
        expect(result).to eq(12.0)
      end

      it 'gives handling fee plus min price with defaults and 1 items' do
        basket = create :basket_with_item
        result = price_for_basket(basket , :handling_fee => 5)
        expect(result).to eq(7.0)
      end

      it 'gives no handling fee just min price with defaults and 1 items' do
        basket = create :basket_with_item
        result = price_for_basket(basket )
        expect(result).to eq(2.0)
      end
    end
    context "free shipping " do
      it "gives 0 for more than 100 cost, default setting " do
        basket = basket_with({:weight =>  10.0} , { price: 110.0} )
        result = price_for_basket(basket)
        expect(result).to eq(0.0)
      end
      it "gives non 0 for less than 100 cost, default setting " do
        basket = basket_with({:weight =>  10.0} , { price: 90.0} )
        result = price_for_basket(basket)
        expect(result).to eq(15.0)
      end
      it 'gives 0 when total price is more than the MAX, for one item (different max)' do
        basket = basket_with({:weight =>  15.0} , {:price => 350} )
        result = price_for_basket(basket , :max_price => 300.0)
        expect(result).to eq(0.0)
      end
    end
    context '.price_for(basket)' do
      it 'gives next price for 1.5 kg item => 5' do
        basket = basket_with({:weight =>  1.5}  )
        result = price_for_basket(basket)
        expect(result).to eq(5.0)
      end

      it 'gives next price for 2.5 kg item => 10' do
        basket = basket_with({:weight =>  2.5}  )
        result = price_for_basket(basket)
        expect(result).to eq(10.0)
      end

      it 'gives 15.0 when total price is 100 and weight is 10kg' do
        basket = basket_with({:weight =>  10.0}  )
        result = price_for_basket(basket)
        expect(result).to eq(15.0)
      end

      it 'gives 15.0 when total price is 40 and weight is 10kg' do
        basket = basket_with({:weight =>  10.0} , { price: 40.0} )
        result = price_for_basket(basket)
        expect(result).to eq(15.0)
      end

      it 'gives 6 when total price is 60 and weight is less than 1kg' do
        basket = basket_with({:weight =>  0.5} , { price: 60.0} )
        result = price_for_basket(basket)
        expect(result).to eq(2.0)
      end

      it 'gives 30 when total price is 200 and weight is 25kg (split into two)' do
        basket = basket_with({:weight =>  25.0} , {:price => 200.0} )
        result = price_for_basket(basket , :max_price => 250)
        expect(result).to eq(28.0)
      end
    end
  end

  describe 'when preferred max is 20 kg' do
    context '.available?(package)' do
      it 'is false when item weighs more than 20kg' do
        basket = basket_with(:weight => 25 )
        expect(OfficeClerk::Post.new({}).available?(basket)).to be(false)
      end
    end
  end

  context "unladed classes" do
    it " dont crash" do
      OfficeClerk::ShippingMethod.all.each do |name , method|
        expect(method.name).not_to include("missing")
      end
    end
  end
  def basket_with product = {}, item = {}
    basket = create :basket_with_item
    basket.items.first.product.update_attributes!(product)
    basket.items.first.update_attributes!(item)
    basket.cache_total #TODO after save hook does not work to automatically update the totals
    basket
  end
  def price_for_basket(basket , args = {})
    OfficeClerk::Post.new(args).price_for(basket)
  end

  context 'returns description' do
    %w(en fi).each do |locale|
      it "in supported language: #{locale}" do
        I18n.with_locale(locale.to_sym) do
          OfficeClerk::ShippingMethod.all.each do |name , method|
            next if (name == "duda") || (name == "Nouto")
            expect(method.name).not_to be_blank
          end
        end
      end
    end
  end

end
