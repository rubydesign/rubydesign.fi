class Supplier < ActiveRecord::Base

  default_scope { order('supplier_name') }

  has_many :products, :dependent => :nullify

  store :address, accessors: [ :name , :street , :city , :country , :phone ] #, coder: JSON

  validates :supplier_name, :presence => true

  def whole_address
    [ name , street , city , country , phone ].join(" ")
  end

end
