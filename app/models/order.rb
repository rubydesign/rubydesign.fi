class Order < ActiveRecord::Base
  has_one :basket , :as => :kori , :autosave => true

  def total_price
    basket.total_price + shipping_price
  end

  #should be an array later (different rates)
  def total_tax
    basket.total_tax + shipping_tax*shipping_price
  end

end
