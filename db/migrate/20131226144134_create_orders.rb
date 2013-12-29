class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :ordered_on
      t.float :total_price
      t.float :total_tax
      t.float :shipping_price
      t.float :shipping_tax
      t.references :basket
      t.string :email
      t.date :paid_on
      t.date :shipped_on
      t.date :paid_on
      t.date :canceled_on
      t.string :shipment_type

      t.timestamps
    end
  end
end
