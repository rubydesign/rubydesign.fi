class Order < ActiveRecord::Base
  has_one :basket , :as => :kori , :autosave => true

  store :address, accessors: [ :name , :street , :city , :phone ] , coder: JSON

  default_scope { order('created_at DESC') } 

  def total_price
    basket.total_price + shipping_price
  end

  #should be an array later (different rates)
  def total_tax
    basket.total_tax + shipping_tax*shipping_price
  end

end
