# This migration comes from office (originally 20131226144316)
class Baskets < ActiveRecord::Migration[4.2]
  def change
    create_table :baskets do |t|
      t.integer     :kori_id
      t.string      :kori_type
      t.decimal     :total_price , :default => 0.0, precision: 10, scale: 4
      t.decimal     :total_tax ,   :default => 0.0, precision: 10, scale: 4
      t.date        :locked
      t.timestamps
    end
  end
end
