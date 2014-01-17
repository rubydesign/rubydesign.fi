class Purchase < ActiveRecord::Base
  
  belongs_to :basket #wording is wrong, but thats ar for you. should be has_one, but the key is here

  def order!
    ordered_on = Date.today
    save!
  end
  
  def receive!
    self.ordered_on = Date.today unless ordered_on 
    self.received_on = Date.today
    self.save!
    basket.receive!
  end
  
  def inventory!
    self.ordered_on = Date.today unless ordered_on 
    self.received_on = Date.today
    self.save!
    basket.inventory!
  end
  
  def self.for_basket b
    purchase = create! :basket => b
    b.set_purchase purchase
    purchase
  end

end
