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
      t.string :properties
      t.string :scode
      t.references :product, index: true
      t.references :product_group, index: true
      t.references :supplier, index: true

      t.timestamps
    end
  end
end
