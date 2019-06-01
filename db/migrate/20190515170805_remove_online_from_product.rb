class RemoveOnlineFromProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :online, :boolean
    remove_column :categories, :online, :boolean
  end
end
