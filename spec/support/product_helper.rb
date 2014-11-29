module ProductHelper
  def product_count
    click_button(:filter)
    all(".image").count
  end
  def create_ab type , hash
    attribute , values = hash.first
    values.each do | value|
      create type , attribute => value
    end
  end
  def product_ab hash
    create_ab :product , hash
    visit products_path
  end
  def category_ab hash
    create_ab :category , hash
    visit categories_path
  end
  alias :category_count :product_count
end

RSpec.configure do |config|
  config.include ProductHelper
end
