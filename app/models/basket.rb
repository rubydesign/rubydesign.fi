class Basket < ActiveRecord::Base

  default_scope { order('created_at DESC') }

  belongs_to :kori, polymorphic: true  #kori is basket in finnish

  has_many :items, autosave: true
  before_save :cache_total

  accepts_nested_attributes_for :items

  def quantity
    items.sum(:quantity)
  end
  def cache_total
    self.total_price = items.to_a.sum{ |i| i.price * i.quantity}
  end
  def touch
    cache_total
    save
    super
  end
  
  #return a hash of rate => amount
  def taxes
    taxes = Hash.new(0.0)
    items.each do |item|
      taxes[item.tax] += item.tax_amount
    end
    taxes
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
    self.kori_type
  end

  def isa typ
    return typ == :cart  if self.type == nil
    self.type.downcase == typ.to_s
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
