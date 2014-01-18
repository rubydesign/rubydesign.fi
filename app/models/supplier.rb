class Supplier < ActiveRecord::Base
  has_many :products, :dependent => :nullify

  store :address, accessors: [ :name , :street , :city , :country , :phone ] , coder: JSON

  validates :supplier_name, :presence => true

  def whole_address
    [ name , street , city , country , phone ].join(" ")
  end

end
