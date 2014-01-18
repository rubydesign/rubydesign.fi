class Supplier < ActiveRecord::Base
  has_many :products, :dependent => :nullify

  store :address, accessors: [ :name , :street , :city , :country , :phone ] , coder: JSON

  validates :supplier_name, :presence => true

end
