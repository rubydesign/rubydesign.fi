 require 'bcrypt'
 
class Clerk < ActiveRecord::Base
  PEPPER = "0bfa9e2cb4a5efd0d976518a3d82e345060547913d2fd1dd2f32b0c8dbbbb5d3dc20b86d0fed31aca9513bccdf51643700ea277d9c64d9ce8ef886bf39293453"
  has_many :basket

  attr_accessor :password , :password_confirmation

  before_validation :prepare_password
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_presence_of :encrypted_password

  validates_uniqueness_of :email
  validates :email, :presence => true, :email => true  # extra gem to check email validity

  store :address, accessors: [ :name , :street , :city , :phone ] , coder: JSON

  def whole_address
    [ name , street , city , phone ].join(" ")
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

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.encrypted_password = encrypt_password(password)
    end
  end
  def encrypt_password(password)
    encrypted = [password, self.password_salt].flatten.join('')
    20.times { encrypted = Digest::SHA512.hexdigest(encrypted) }
    encrypted
  end
end
