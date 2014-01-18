class Purchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.date :ordered_on
      t.date :received_on

      t.timestamps
    end
  end
end
