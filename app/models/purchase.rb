class Purchase < ActiveRecord::Base
  
  belongs_to :basket #wording is wrong, but thats ar for you. should be has_one, but the key is here

  def order!
    ordered_on = Date.today
    save!
  end
  
  def receive!
    ordered_on = Date.today unless ordered_on 
    received_on = Date.today
    sum = 0
    basket.items.each do |item|
      item.product.inventory += item.quantity
      sum += item.quantity
      item.product.save!
    end
    save!
    sum
  end
  
  def self.for_basket b
    purchase = create! :basket => b
    b.set_purchase purchase
    purchase
  end

end
