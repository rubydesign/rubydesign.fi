class AddSupplierToPurchase < ActiveRecord::Migration[5.0]
  def change
    add_reference :purchases, :supplier, foreign_key: true
  end
end
