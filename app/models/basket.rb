class Basket < ActiveRecord::Base
  has_one :purchase
  has_many :items, autosave: true
  
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

  def add_product prod
    exists = items.where(:product_id => prod.id ).limit(1).first
    if exists
      exists.quantity += 1
    else
      exists = items.new :quantity => 1 , :product => prod , :price => prod.price , :tax => prod.tax
    end
    exists.save!
    reload
  end
end
