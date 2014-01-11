class Basket < ActiveRecord::Base
  has_one :purchase
  has_one :order
  has_many :items, autosave: true
  before_save :cache_totals
  
  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  validates :name, :presence => true
  accepts_nested_attributes_for :items

  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

  def cache_totals
    self.total_price = items.sum{ |i| i.price * i.quantity}
    self.total_tax   = items.inject(0){|sum,i| sum + i.tax * i.quantity * i.price / 100.0}
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
  #type is one of order purchase , user or cart depending on who "owns" the basket
  def type
    name.split.first.downcase
  end
  def isa typ
    self.type == typ.to_s
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
