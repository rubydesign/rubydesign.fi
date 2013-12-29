class Product < ActiveRecord::Base
  has_many :products, :dependent => :nullify
  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

  def self.permitted_attributes
    return :price,:cost,:weight,:name,:description,:url_name,:ean,:tax,:properties,:scode,:product_id,:product_group_id,:supplier_id
  end
  belongs_to :product
  belongs_to :product_group
  belongs_to :supplier
end
