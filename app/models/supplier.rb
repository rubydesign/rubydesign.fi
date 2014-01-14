class Supplier < ActiveRecord::Base
  has_many :products, :dependent => :nullify
  belongs_to :address , :validate => true ,  autosave: true
  accepts_nested_attributes_for :address
  validates :name, :presence => true

end
