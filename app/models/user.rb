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

 #some stackoverflow magic to use old passwords  and update them as needed
 alias :devise_valid_password? :valid_password?
 def valid_password?(password)
   begin
     super(password)
   rescue BCrypt::Errors::InvalidHash
     digest = password_digest(password)
     puts "digested #{digest}"
     secure_compare(digest, self.encrypted_password)
     logger.info "User #{email} is using the old password hashing method, updating attribute."
     self.password = password
     true
   end
 end

  #still to be taken into use
  def has_role? role
    true
  end
 
  #compatibility (to my old devise 2.0.5) code
  def secure_compare(a, b)
    return false if a.blank? || b.blank? || a.bytesize != b.bytesize
    l = a.unpack "C#{a.bytesize}"
    res = 0
    b.each_byte { |byte| res |= byte ^ l.shift }
    res == 0
  end
  def password_digest(password)
    pepper ="0bfa9e2cb4a5efd0d976518a3d82e345060547913d2fd1dd2f32b0c8dbbbb5d3dc20b86d0fed31aca9513bccdf51643700ea277d9c64d9ce8ef886bf39293453"
    #raisas salt
    salt ="2687dd72bb98a22f5e9d42db3c85bbea7e22ff13fbc0e9f428613d90aeb49ef2fee17af670f069758e3cc01688cc1d91110cf8285e8df14c496c7bc2f816f727"
    stretches = 20
    digest = [password, salt].flatten.join('')
    stretches.times { digest = Digest::SHA512.hexdigest(digest) }
    digest
  end
   
 
end
