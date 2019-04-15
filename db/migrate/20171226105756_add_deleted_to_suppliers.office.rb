# This migration comes from office (originally 20171226105632)
class AddDeletedToSuppliers < ActiveRecord::Migration[4.2][5.0]
  def change
    add_column :suppliers, :deleted_on, :date
    add_column :products,  :pack_unit, :integer
  end
end
