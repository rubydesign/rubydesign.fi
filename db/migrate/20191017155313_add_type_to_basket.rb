class AddTypeToBasket < ActiveRecord::Migration[5.2]
  def change
    add_column :baskets, :kind, :string
    add_column :products, :phase, :integer, default: 1
    add_column :products, :dimension, :integer, default: 1
  end
end
