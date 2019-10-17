# RubyClerk product may represent one of three things
# - the normal product (all attributes work as expected)
# - a product line, in which case it may not be sold and inventory is the sum of the items
#                   other attributes (like price/cost) act as a template and are copied into children
#                   where they are then used.
# - an (line) item of a product line, in which case the default view concatenates name and description and
#                   shows prices relative to it's parent
#
# This makes the model a three headed one and validation is a little more complicated
# - a product line _may not_ have an ean (as it can't be sold)
# - a product and product line _must_ have a link , but  (those are generated if needed)
# - line item _may not_ have a link (this is enforced, not validated)

# attributes : see permitted_attributes + inventory + deleted_on

class Product < ActiveRecord::Base
  has_many :items
  store :properties, accessors: [ :color, :size , :model_number ] #, coder: JSON
  belongs_to :category , optional: true
  belongs_to :supplier , optional: true

  # default product scope only lists non-deleted products
  default_scope {where(:deleted_on => nil).order(created_at: :desc) }
  scope :with_inventory, -> { where("inventory > 0") }

  validates :price, :numericality => true
  validates :cost, :numericality => true
  validates :name, :presence => true
  validates :deleted_on , :absence => true , :if => :has_inventory?

  before_save :check_attributes
  before_save :fix_cost

  # if no url is set we generate one based on the name
  # but product_items don't have urls, so not for them
  def check_attributes
    self.link = self.name.gsub(" " , "_").downcase if self.link.blank? && self.name != nil
  end

  def has_inventory?
    self.inventory > 0
  end

  # has the product been deleted (marked as deleted)
  def deleted?
    not deleted_on.blank?
  end

  # deleting sets the deleted_on flag to today
  # Products can not be deleted because of the risk of invalidating old orders
  # to actually remove a product from the db, use the console
  def delete
    self.deleted_on = Date.today
    self.link = ""
    self
  end

  def category_name
    self.category_id ? self.category.name : ""
  end

  def copy_product
    Product.new :tax => self.tax , :weight => self.weight , :cost => self.cost ,
        :supplier_id => self.supplier_id , :category_id => self.category_id ,
        :price => self.price , :name => self.name + " copy"
  end

  private
  def fix_cost
    if self.cost == 0.0
      self.cost = self.price / 2
    end
  end
end
