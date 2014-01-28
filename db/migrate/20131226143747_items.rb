class Items < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer     :quantity , :default => 1
      t.float       :price , :default => 0
      t.float       :tax , :default => 0
      t.string      :name
      t.references  :product
      t.references  :basket

      t.timestamps
    end
  end
end
