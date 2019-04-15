# This migration comes from office (originally 20171225183132)
class AddDeletedToCategories < ActiveRecord::Migration[4.2][5.0]
  def change
    add_column :categories, :deleted_on , :date
  end
end
