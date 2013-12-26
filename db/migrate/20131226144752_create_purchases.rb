class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.date :ordered_on
      t.string :received_on_date
      t.reference :bucket
      t.referece :supplier

      t.timestamps
    end
  end
end
