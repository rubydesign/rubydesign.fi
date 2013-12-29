class CreateProductGroups < ActiveRecord::Migration
  def change
    create_table :product_groups do |t|
      t.references :product_group
      t.string :name
      t.string :url_name
      t.string :picture

      t.timestamps
    end
  end
end
