class Category < ActiveRecord::Base

  default_scope { order('position') }

  has_many :products, :dependent => :nullify
  has_many :categories, :dependent => :nullify
  belongs_to :category
  has_attached_file :main_picture
  has_attached_file :extra_picture

  validates :name, :presence => true
  validates :link, presence: true, :if => :generate_url_if_needed

  scope :online, -> { where(:online => true) }

  def generate_url_if_needed
    if self.link.blank? && self.name != nil
      self.link = self.name.gsub(" " , "_").downcase
    end
    true
  end

end
