class Purchase < ActiveRecord::Base
  
  belongs_to :basket #wording is wrong, but thats ar for you. should be has_one, but the key is here
  belongs_to :supplier

  def self.permitted_attributes
    return :name,:ordered_on,:received_on,:basket_id,:supplier
  end

  belongs_to :basket
end
