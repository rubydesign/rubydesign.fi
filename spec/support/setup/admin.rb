unless Clerk.where( :email =>  "admin@important.me").first
  admin = Clerk.new( :email =>  "admin@important.me" , :admin => true , :password => "password" ) 
   admin.save!
end
