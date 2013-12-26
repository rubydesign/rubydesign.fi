class AddAddressToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :address_id, :integer
    add_index :suppliers, :address_id
  end
end
