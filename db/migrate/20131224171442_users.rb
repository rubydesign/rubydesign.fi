class Users < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email,              :null => false, :default => ""
      t.boolean :admin , :default => false
      
      #these two are json attributes, so can be added to easily
      t.string :password 
      t.string  :address
      t.timestamps
    end
    add_index :users, :email,                :unique => true
  end
end
