module ProductHelper
  def product_count
    all(".image").count
  end
  def create_ab hash
    attribute , values = hash.first
    values.each do | value|
      create :product , attribute => value
    end
    visit products_path
  end
end

RSpec.configure do |config|
  config.include ProductHelper
end
