class Suppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string      :supplier_name
      t.string      :address
      t.timestamps
    end
  end
end
