class AddDeletedToSuppliers < ActiveRecord::Migration[5.0]
  def change
    add_column :suppliers, :deleted_on, :date
    add_column :products,  :pack_unit, :integer
  end
end
