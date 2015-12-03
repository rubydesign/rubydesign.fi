class Basket < ActiveRecord::Base

  default_scope { order('created_at DESC') }

  belongs_to :kori, polymorphic: true  #kori is basket in finnish

  has_many :items, autosave: true , :dependent => :destroy

  before_save :cache_total

  accepts_nested_attributes_for :items

  def quantity
    items.sum(:quantity)
  end

  def empty?
    self.items.empty?
  end

  def locked?
    not self.locked.blank?
  end

  def cache_total
    self.total_price = (items.to_a.sum{ |i| i.total }).round(2)
    self.total_tax =  (items.to_a.sum{ |i| i.tax_amount}).round(2)
  end

  def touch
    cache_total
    super
    save!
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
  # locks the basket so receiving or deducting becomes an error.
  def receive!
    raise "Locked since #{self.locked}" if locked?
    sum = do_receive(true) # change the prices
    self.locked = Date.today
    self.save!
    sum
  end

  # deduct the items from inventory, change affects immediately in the products
  # locks the basket so receiving or deducting becomes an error.
  def deduct!
    raise "Locked since #{self.locked}" if locked?
    sum = 0
    self.items.each do |item|
      prod = item.product
      prod.inventory = prod.inventory - item.quantity
      sum += item.quantity
      prod.save!
    end
    self.locked = Date.today
    self.save!
    sum
  end

  # return inventory and unlock basket
  # very similar to receive, just we don't change prices (and don't lock)
  def unlock_order!
    self.locked = nil
    do_receive(false) #don't change prices
    self.save!
  end

  # inventorying the basket means setting the item quantity as the stock
  # we actually change the basket for it to be a relative change (so as to look like a receive)
  def inventory!
    self.items.each { |item| item.quantity -= item.product.inventory  }
    self.receive!
  end

  # set all items prices to zero
  def zero_prices!
    raise "Locked since #{self.locked}" if locked?
    self.items.each do |item|
      item.price = 0.0
    end
    self.save!
  end

  def isa typ
    self.kori_type.to_s.downcase == typ.to_s.downcase && self.kori_id != nil
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
    return unless quant != 0
    raise "Locked since #{self.locked}" if locked?
    exists = items.where(:product_id => prod.id ).limit(1).first
    if exists
      exists.quantity += quant
    else
      exists = items.new :quantity => quant , :product => prod , :price => prod.price ,
                         :tax => prod.tax , :name => prod.full_name
    end
    if( exists.quantity == 0)
      exists.delete
      touch
    else
      exists.save!
    end
    reload
  end
  private
  def do_receive change_prices
    sum = 0
    self.items.each do |item|
      prod = item.product
      prod.inventory = prod.inventory + item.quantity
      prod.save!
      sum += item.quantity
      item.price = item.product.cost if change_prices
    end
    sum
  end
end
