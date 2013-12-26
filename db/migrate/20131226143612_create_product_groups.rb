class CreateProductGroups < ActiveRecord::Migration
  def change
    create_table :product_groups do |t|
      t.reference :product_group
      t.string :name
      t.string :slug
      t.string :picture

      t.timestamps
    end
  end
end
