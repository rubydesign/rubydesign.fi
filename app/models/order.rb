class Order < ActiveRecord::Base
  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

  def self.permitted_attributes
    return :ordered_on,:total_price,:total_tax,:shipping_price,:shipping_tax,:basket_id,:email,:paid_on,:shipped_on,:paid_on,:canceled_on,:shipment_type
  end
end
