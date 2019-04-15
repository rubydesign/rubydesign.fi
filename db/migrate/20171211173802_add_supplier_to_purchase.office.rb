# This migration comes from office (originally 20171211173158)
class AddSupplierToPurchase < ActiveRecord::Migration[4.2][5.0]
  def change
    add_reference :purchases, :supplier, foreign_key: true
  end
end
