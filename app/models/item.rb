class Item < ActiveRecord::Base
  belongs_to :basket , :touch => true
  belongs_to :product

  validates :name, :presence => true

  # total price, ie quantity times price
  def total
    self.price * self.quantity
  end

  def product
    Product.unscoped.find self.product_id
  end

  # tax included in the total
  def tax_amount
    self.quantity * single_item_tax
  end

  #relation of price to product price down from 100 %
  def discount
    return 0 unless product.price and product.price != 0
    (100 - (price/product.price)*100).round(0)
  end

  def single_item_tax
    (self.price * self.tax / ( 100.0 + self.tax)).round(4)
  end
end
