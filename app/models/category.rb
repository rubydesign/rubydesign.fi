class Category < ActiveRecord::Base

  default_scope {where(:deleted_on => nil). order('position') }

  has_many :products, :dependent => :nullify
  has_many :categories, :dependent => :nullify
  belongs_to :category, optional: true

  validates :name, :presence => true

  # deleting sets the deleted_on flag to today
  # Categories can not be deleted because of the risk of invalidating old orders
  # to actually remove a Category from the db, use the console
  def delete
    self.deleted_on = Date.today
    self
  end

end
