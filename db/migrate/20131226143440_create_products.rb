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
      t.references :product
      t.references :product_group
      t.references :supplier

      t.timestamps
    end
  end
end
