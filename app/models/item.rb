class Item < ActiveRecord::Base
  belongs_to :basket , :touch => true
  belongs_to :product

  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  def total
    self.price * self.quantity
  end

  #relation of price to product price down from 100 %
  def discount
    return 0 unless product.price and product.price != 0
    (100 - (price/product.price)*100).round(0)
  end

  def self.permitted_attributes
    return :basket_id,:quantity,:price,:tax,:product_id
  end
end
