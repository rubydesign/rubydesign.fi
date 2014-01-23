class Order < ActiveRecord::Base
  has_one :basket , :as => :kori , :autosave => true

  store :address, accessors: [ :name , :street , :city , :phone ] , coder: JSON

  default_scope { order('created_at DESC').includes(:basket) }

  def total_price
    basket.total_price + shipping_price
  end

  #should be an array later (different rates)
  def total_tax
    basket.total_tax + shipping_tax*shipping_price
  end

  #return a hash of rate => amount
  def taxes
    cart = basket.taxes
    s_tax = self.shipping_price * shipping_tax
    #relies on basket creating a default value of 0
    cart[self.shipping_tax] += s_tax if self.shipping_tax and self.shipping_tax != 0
    cart
  end
end
