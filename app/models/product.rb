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
  belongs_to :product
  belongs_to :category
  belongs_to :supplier
  has_attached_file :main_picture
  has_attached_file :extra_picture

  # default product scope only lists non-deleted products
  default_scope where(:deleted_on => nil)
 
  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  validates :price, :numericality => true 
  validates :cost, :numericality => true
  validates :name, :presence => true
  validates :link, presence: true, :if => :generate_url_if_needed
 
  def generate_url_if_needed
    if link.blank? && name != nil
      self.link = name.gsub(" " , "_").downcase
    end
    true
  end
    
  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

end
