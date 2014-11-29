module BasketHelper
  def expect_basket_total price
    expect(find(".total").text).to include( price.round(2).to_s.sub(".",",")) # TODO remove the format hack 
  end
end

RSpec.configure do |config|
  config.include BasketHelper
end
