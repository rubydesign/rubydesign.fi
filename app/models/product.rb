# RubyClerk product may represent one of three things
# - the normal product (all attributes work as expected)
# - a product line, in which case it may not be sold and inventory is meaningless
#                   other attributes (like price/cost) act as a template and are copied into children
#                   where they are then used.
# - a member of a product line, in which case the default view concatenates name and description and 
#                   shows prices relative to it's parent
#  

# attributes : see permitted_attributes + inventory + deleted_on

class Product < ActiveRecord::Base
  has_many :products, :dependent => :nullify
  has_many :images, -> {order(:position)}, :dependent => :destroy
  belongs_to :product
  belongs_to :product_group
  belongs_to :supplier

  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  # default product scope only lists non-deleted variants
  scope :active, lambda { where(:deleted_on => nil) }
  scope :deleted, lambda { where('deleted_on IS NOT NULL') }

  validates :price, :numericality => true , :presence => true
  validates :cost_price, :numericality => true
  validates :name, :presence => true
  validates :url_name, presence: true, :if => :generate_url_if_needed
 
  def generate_url_if_needed
    unless url_name
      url_name = name.gsub(" " , "_").downcase
    end
    true
  end
    def paid_with_card?
      payment_type == "card"
    end
    
  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

  def self.permitted_attributes
    return :price,:cost,:weight,:name,:description,:url_name,:ean,:tax,:properties,:scode,:product_id,:product_group_id,:supplier_id
  end
end
