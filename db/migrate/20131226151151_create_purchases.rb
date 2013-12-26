class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.date :ordered_on
      t.string :received_on_date
      t.references :bucket, index: true
      t.refereces :supplier

      t.timestamps
    end
  end
end
