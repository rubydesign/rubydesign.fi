class Purchase < ActiveRecord::Base
  
  has_one :basket , :as => :kori ,  :autosave => true
  
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
  
end
