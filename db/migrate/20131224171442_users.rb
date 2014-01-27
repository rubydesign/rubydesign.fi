class Users < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email,              :null => false, :default => ""
      t.boolean :admin , :default => false
      t.string :encrypted_password
      t.string :password_salt

      #this is a json attribute, so anything can be added to the class easily
      t.string  :address
      t.timestamps
    end
    add_index :users, :email,                :unique => true
  end
end
