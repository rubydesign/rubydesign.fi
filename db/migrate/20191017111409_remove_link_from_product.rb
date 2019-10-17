class RemoveLinkFromProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :link, :string
    remove_column :categories, :link, :string
  end
end
