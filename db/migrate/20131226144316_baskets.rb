class Baskets < ActiveRecord::Migration
  def change
    create_table :baskets do |t|
      t.string      :name
      t.decimal     :total_price , :default => 0.0
      t.decimal     :total_tax ,   :default => 0.0
      t.timestamps
    end
  end
end
