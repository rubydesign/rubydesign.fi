# This migration comes from office (originally 20131226110406)
class Suppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string      :supplier_name
      t.string      :address
      t.timestamps null: false
    end
  end
end
