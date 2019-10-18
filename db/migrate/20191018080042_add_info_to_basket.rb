class AddInfoToBasket < ActiveRecord::Migration[5.2]
  def change
    add_column :baskets, :info, :string
    add_column :items,   :info, :string
    remove_column :products, :properties, :string
  end
end
