class Purchase < ActiveRecord::Base
  
  belongs_to :basket #wording is wrong, but thats ar for you. should be has_one, but the key is here
  belongs_to :supplier

  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  def self.permitted_attributes
    return :name,:ordered_on,:received_on,:basket_id,:supplier
  end
  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  belongs_to :basket
end
