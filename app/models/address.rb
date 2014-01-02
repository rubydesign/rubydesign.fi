class Address < ActiveRecord::Base

  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :street1, :presence => true
  validates :postcode, :presence => true

  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

  def self.permitted_attributes
    return :first_name,:last_name,:street1,:street2,:postcode,:country
  end
end
