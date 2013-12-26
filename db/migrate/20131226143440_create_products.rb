class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.float :price
      t.float :cost
      t.float :weight
      t.string :name
      t.text :description
      t.string :slug
      t.string :ean
      t.float :tax
      t.string :attributes
      t.string :scode
      t.reference :product
      t.reference :product_group
      t.reference :supplier

      t.timestamps
    end
  end
end
