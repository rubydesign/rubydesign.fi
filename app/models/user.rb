class User < ActiveRecord::Base
  PEPPER = "0bfa9e2cb4a5efd0d976518a3d82e345060547913d2fd1dd2f32b0c8dbbbb5d3dc20b86d0fed31aca9513bccdf51643700ea277d9c64d9ce8ef886bf39293453"
  has_many :basket

  after_create :prepare_password
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  store :address, accessors: [ :name , :street , :city , :phone ] , coder: JSON

  def whole_address
    [ name , street , city , phone ].join(" ")
  end

  #still to be taken into use
  def has_role? role
    true
  end
  
  def valid_password?(password)
    return false if password.blank? 
    encrypted = encrypt_password(password)
    return false if self.encrypted_password.blank? || encrypted.bytesize != self.encrypted_password.bytesize
    left = encrypted.unpack "C#{encrypted.bytesize}"
    res = 0
    self.encrypted_password.each_byte { |byte| res |= byte ^ left.shift }
    res == 0
  end
  def encrypt_password(password)
    encrypted = [password, self.password_salt].flatten.join('')
    20.times { encrypted = Digest::SHA512.hexdigest(encrypted) }
    encrypted
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.encrypted_password = encrypt_password(password)
    end
  end
end
