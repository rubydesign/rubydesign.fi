class Addresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street1
      t.string :street2
      t.string :city
      t.string :phone
      t.string :country

      t.timestamps
    end
  end
end
