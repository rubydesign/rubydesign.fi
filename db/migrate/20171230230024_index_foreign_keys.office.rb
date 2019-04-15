# This migration comes from office (originally 20171230210527)
class IndexForeignKeys < ActiveRecord::Migration[4.2][5.0]
  def change
    add_index :categories, :category_id
    add_index :items, :basket_id
    add_index :items, :product_id
    add_index :baskets, :kori_id
    add_column :orders, :message , :string
  end
end
