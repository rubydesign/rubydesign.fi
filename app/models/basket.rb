class Basket < ActiveRecord::Base
  has_one :purchase
  has_one :order
  has_many :items, autosave: true
  before_save :cache_totals
  
  validates :name, :presence => true
  accepts_nested_attributes_for :items

  def quantity
    items.sum(:quantity)
  end
  def cache_totals
    self.total_price = items.sum{ |i| i.price * i.quantity}
  end
  def touch
    cache_totals
    save
    super
  end
  def set_order o
    self.name = "order " + o.id.to_s
    save!
  end
  def order
    return nil unless isa :order
    order_id = name.split.last
    Order.find order_id
  end
  def set_purchase o
    self.name = "purchase " + o.id.to_s
    save!
  end
  def purchase
    return nil unless isa :purchase
    purchase_id = name.split.last
    Purchase.find purchase_id
  end
  # receiving the goods means that the item quantity is added to the stock (product.inventory)
  # also we change the price to the products cost price
  def receive!
    sum = 0
    self.items.each do |item|
      item.product.inventory += item.quantity
      sum += item.quantity
      item.price = item.product.cost
      item.product.save!
      item.save!
    end
    sum
  end
  #inventoying the basket means setting the item quantity as the stock
  #we actually change the basket for it to be a relative change (so as to look like a receive)
  def inventory!
    self.items.each { |item| item.quantity -= item.product.inventory  }
    self.receive!
  end
  
  #type is one of order purchase , user or cart depending on who "owns" the basket
  def type
    name.split.first.downcase
  end
  
  def isa typ
    self.type == typ.to_s
  end
  
  def suppliers
    ss = items.collect{|i| i.product.supplier if i.product}
    ss.uniq!
    ss.delete(nil)
    ss
  end
  #when adding a product (with quantity) we ensure there is only one item for each product
  def add_product prod , quant = 1
    return unless prod
    exists = items.where(:product_id => prod.id ).limit(1).first
    if exists
      exists.quantity += quant
    else
      exists = items.new :quantity => quant , :product => prod , :price => prod.price , :tax => prod.tax
    end
    exists.save!
    reload
  end
end
