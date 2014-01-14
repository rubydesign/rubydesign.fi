class Category < ActiveRecord::Base
  has_many :products, :dependent => :nullify
  has_many :categories, :dependent => :nullify
  has_attached_file :main_picture
  has_attached_file :extra_picture

  validates :name, :presence => true
  validates :link, presence: true, :if => :generate_url_if_needed
 
  def generate_url_if_needed
    if link.blank? && name != nil
      self.link = name.gsub(" " , "_").downcase
    end
    true
  end

end
