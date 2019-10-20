class Item < ActiveRecord::Base
  belongs_to :basket , touch: true , optional: true
  belongs_to :product , optional: true

  validates :name, presence: true
  validates :quantity, numericality: true
  validates :price, numericality: true

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

  # profit is off course the sale price minus the cost
  # but . .. while the sale price is copied to the item and thus remains correct
  # when the cost changes over time, so does this "profit".
  def profit
    (self.price - self.product.cost) * self.quantity
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
