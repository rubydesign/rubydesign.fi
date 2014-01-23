class Order < ActiveRecord::Base
  has_one :basket , :as => :kori , :autosave => true

  store :address, accessors: [ :name , :street , :city , :phone ] , coder: JSON

  before_validation :generate_order_number, :on => :create

  default_scope { order('created_at DESC').includes(:basket) }

  # many a european goverment requires buisnesses to have running order/transaction numbers.
  # this is what we use, but it can easily be changed by redifining this method
  # format RYYYYRUNIN  R, 4 digit year and a running number
  def generate_order_number
    if last = Order.first # last, but default order is reversed
      num = last.number[5..9].to_i + 1
    else
      num = 30000
    end
    self.number = "R#{Time.now.year}#{num}"
  end

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
