class Category < ActiveRecord::Base

  default_scope {where(:deleted_on => nil). order('position') }

  has_many :products, :dependent => :nullify
  has_many :categories, :dependent => :nullify
  belongs_to :category
  has_attached_file :main_picture
  validates_attachment_content_type :main_picture, :content_type => /\Aimage\/.*\Z/

  validates :name, :presence => true
  validates :link, presence: true, :if => :generate_url_if_needed

  scope :online, -> { where(:online => true) }

  def generate_url_if_needed
    if self.deleted_on.blank?
      self.link = self.name.gsub(" " , "_").downcase if self.link.blank? && self.name != nil
      return true
    else
      return false
    end
  end

  # deleting sets the deleted_on flag to today
  # Categories can not be deleted because of the risk of invalidating old orders
  # to actually remove a Category from the db, use the console
  def delete
    self.deleted_on = Date.today
    self.link = "pois_#{self.id}"
    self
  end

  # just a shorthand to apply Products.shop_products scope to the groups products
  def shop_products
    products.shop_products
  end
end
