class User < ActiveRecord::Base
  belongs_to :address
  belongs_to :basket

  def self.permitted_attributes
    return :email,:name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
   def has_role? role
     true
   end
end
