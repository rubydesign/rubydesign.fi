class AddDeletedToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :deleted_on , :date
  end
end
