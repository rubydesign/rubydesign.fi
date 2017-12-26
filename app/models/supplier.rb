class Supplier < ActiveRecord::Base

  default_scope { where(:deleted_on => nil).order('supplier_name') }

  has_many :products, :dependent => :nullify

  store :address, accessors: [ :name , :street , :city , :country , :phone ] #, coder: JSON

  validates :supplier_name, :presence => true

  def whole_address
    [ name , street , city , country , phone ].join(" ")
  end

  # deleting sets the deleted_on flag to today
  # Suppliers can not be deleted because of the risk of invalidating old orders
  # to actually remove a Supplier from the db, use the console
  def delete
    self.deleted_on = Date.today
    self
  end
end
