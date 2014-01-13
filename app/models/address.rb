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
  validates :city, :presence => true

  def self.permitted_attributes
    return :first_name,:last_name,:street1,:street2,:city,:country
  end
end
