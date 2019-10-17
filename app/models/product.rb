# RubyClerk product may represent one of three things
# - the normal product (all attributes work as expected)
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

  before_save :fix_cost

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
