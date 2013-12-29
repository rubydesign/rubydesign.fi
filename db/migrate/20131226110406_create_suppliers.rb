class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string    :name
      t.integer   :address_id
      t.timestamps
    end
  end
end
