class IndexForeignKeys < ActiveRecord::Migration[5.0]
  def change
    add_index :categories, :category_id
    add_index :items, :basket_id
    add_index :items, :product_id
    add_index :baskets, :kori_id
    add_column :orders, :message , :string
  end
end
