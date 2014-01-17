class Purchase < ActiveRecord::Base
  
  belongs_to :basket #wording is wrong, but thats ar for you. should be has_one, but the key is here

  def self.for_basket b
    purchase = create! :basket => b
    b.set_purchase purchase
    purchase
  end

end
