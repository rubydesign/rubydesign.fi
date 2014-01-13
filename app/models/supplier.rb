class Supplier < ActiveRecord::Base
  has_many :products, :dependent => :nullify
  belongs_to :address , :validate => true ,  autosave: true
  accepts_nested_attributes_for :address
  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }
  validates :name, :presence => true

  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }
end
