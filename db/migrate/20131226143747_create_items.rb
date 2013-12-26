class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :quantity
      t.float :price
      t.float :tax
      t.reference :product

      t.timestamps
    end
  end
end
