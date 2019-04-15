# This migration comes from office (originally 20131226110406)
class Suppliers < ActiveRecord::Migration[4.2]
  def change
    create_table :suppliers do |t|
      t.string      :supplier_name
      t.string      :address
      t.timestamps
    end
  end
end
