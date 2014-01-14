class Order < ActiveRecord::Base
  belongs_to :basket , :autosave => true

  def total_price
    basket.total_price + shipping_price
  end

  #should be an array later (different rates)
  def total_tax
    basket.total_tax + shipping_tax*shipping_price
  end

  def self.for_basket b
    order = create! :basket => b
    b.set_order order
    order
  end
end
