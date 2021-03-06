class Basket < ActiveRecord::Base
  ADD = 1
  REMOVE = -1

  store :info, accessors: [ :width, :length , :height , :angle , :name] #, coder: JSON
  validates :width, numericality: true , allow_nil: true
  validates :length, numericality: true, allow_nil: true
  validates :height, numericality: true, allow_nil: true
  validates :angle, numericality: true, allow_nil: true

  belongs_to :kori, polymorphic: true  , optional: true #kori is basket in finnish

  belongs_to :order, -> { where(baskets: {kori_type: 'Order'}).includes( :baskets) },
              foreign_key: 'kori_id' , optional: true

  has_many :items, autosave: true , :dependent => :destroy

  default_scope { order('created_at DESC') }

  accepts_nested_attributes_for :items

  after_touch :update_cache

  def quantity
    items.sum(:quantity)
  end

  def empty?
    self.items.empty?
  end

  def locked?
    not self.locked.blank?
  end

  def update_cache
    total_p = (items.to_a.sum{ |i| i.total }).round(2)
    total_t =  (items.to_a.sum{ |i| i.tax_amount}).round(2)
    return if self.total_price == total_p
    update_attributes!(total_price: total_p ,total_tax: total_t)
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
  # locks the basket so receiving or deducting becomes an error.
  def receive!
    raise "Locked since #{self.locked}" if locked?
    sum = do_adjust( ADD ) # one for adding products
    self.locked = Date.today
    self.save!
    sum
  end

  # deduct the items from inventory, change affects immediately in the products
  # locks the basket so receiving or deducting becomes an error.
  def deduct!
    raise "Locked since #{self.locked}" if locked?
    sum = do_adjust( REMOVE )
    self.locked = Date.today
    self.save!
    sum
  end

  # return inventory and cancel basket
  # very similar to receive, just we don't change prices (and don't lock)
  def cancel_order!
    self.locked = nil
    do_adjust( ADD )
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

  def remove_product(prod)
    raise "Locked since #{self.locked}" if locked?
    item = items.where(:product_id => prod.id ).limit(1).first
    return unless item
    items.delete item
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
      price = (self.kori_type == "Purchase") ? prod.cost : prod.price
      exists = items.new :quantity => quant , :product => prod , :price => price ,
                         :tax => prod.tax , :name => prod.name
    end
    if( exists.quantity == 0)
      items.delete exists
    else
      exists.save!
    end
    reload
  end

  def amount_for(product)
    house = self
    return nil if product.description.blank?
    begin
      eval(product.description).to_f.round(2)
    rescue Exception => e
      "error #{e.class}"
    end
  end


  def width
    self.info[:width].to_f
  end
  def length
    self.info[:length].to_f
  end
  def height
    self.info[:height].to_f
  end
  def angle
    self.info[:angle].to_f
  end

  def gabel_height
    (roof_length * Math.sin((Math::PI * self.angle) / 180)).round(2)
  end

  def roof_length
    (0.5*self.width / Math.cos((Math::PI * self.angle) / 180)).round(2)
  end

  def end_wall_area
    (self.width * (2*self.height + self.gabel_height)).round(2)
  end

  def inner_length
    self.length - 2 * 0.4
  end

  def inner_width
    self.width - 2 * 0.4
  end

  private

  def do_adjust( multiplier )
    sum = 0
    self.items.each do |item|
      prod = item.product
      prod.inventory = prod.inventory + multiplier * item.quantity
      sum += item.quantity
      prod.save!
    end
    sum
  end

end
