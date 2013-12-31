class ProductGroup < ActiveRecord::Base
  has_many :products, :dependent => :nullify
  has_many :product_groups, :dependent => :nullify
  has_attached_file :main_picture
  has_attached_file :extra_picture

  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }
  validates :name, :presence => true
  validates :link, presence: true, :if => :generate_url_if_needed
 
  def generate_url_if_needed
    if link.blank?
      self.link = name.gsub(" " , "_").downcase
    end
    true
  end

  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

  def self.permitted_attributes
    return :product_group_id,:name,:link,:main_picture,:extra_picture
  end
end
