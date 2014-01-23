class User < ActiveRecord::Base

  has_many :basket

  store :address, accessors: [ :name , :street , :city , :phone ] , coder: JSON

  def whole_address
    [ name , street , city , phone ].join(" ")
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   def has_role? role
     true
   end
end
