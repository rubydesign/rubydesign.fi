class Purchase < ActiveRecord::Base

  has_one :basket , :as => :kori ,  :autosave => true

  def order!
    self.ordered_on = Date.today
    save!
  end

  def receive!
    items = basket.receive!
    self.ordered_on = Date.today unless ordered_on
    self.received_on = Date.today
    self.save!
    items
  end

  def inventory!
    items = basket.receive!
    self.ordered_on = Date.today unless ordered_on
    self.received_on = Date.today
    self.save!
    items
  end

end
