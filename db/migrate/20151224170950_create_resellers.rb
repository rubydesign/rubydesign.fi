class CreateResellers < ActiveRecord::Migration
  def change
    create_table :resellers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :link

      t.timestamps null: false
    end
  end
end
