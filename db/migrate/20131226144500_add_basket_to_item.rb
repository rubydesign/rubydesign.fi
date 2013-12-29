class AddBasketToItem < ActiveRecord::Migration
  def change
    add_column :items, :basket_id, :integer
    add_index :items, :basket_id
  end
end
