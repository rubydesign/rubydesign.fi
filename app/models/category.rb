class Category < ActiveRecord::Base
  has_many :products, :dependent => :nullify
  has_many :categories, :dependent => :nullify
  has_attached_file :main_picture
  has_attached_file :extra_picture

  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }
  validates :name, :presence => true
  validates :link, presence: true, :if => :generate_url_if_needed
 
  def generate_url_if_needed
    if link.blank? && name != nil
      self.link = name.gsub(" " , "_").downcase
    end
    true
  end

  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

end
