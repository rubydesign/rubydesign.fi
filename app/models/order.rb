class Order < ActiveRecord::Base
  belongs_to :basket , :autosave => true
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

  def self.for_basket b
    order = create! :basket => b
    b.set_order order
    order
  end
end
