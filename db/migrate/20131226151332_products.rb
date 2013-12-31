class Products < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.float       :price
      t.attachment  :main_picture
      t.attachment  :extra_picture
      t.float   :cost , :default => 0.0
      t.float   :weight , :default => 0.1
      t.string  :name
      t.text    :description
      t.string  :link
      t.string  :ean
      t.float   :tax
      t.integer :inventory , :default => 0
      t.string  :properties
      t.string  :scode
      t.date    :deleted_on
      t.references :product,        index: true
      t.references :product_group,  index: true
      t.references :supplier,       index: true
      t.timestamps
    end
  end
end
