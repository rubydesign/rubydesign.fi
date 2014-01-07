class Products < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.float       :price
      t.string      :name
      t.string      :link
      t.text        :description
      t.attachment  :main_picture
      t.attachment  :extra_picture
      t.boolean     :online ,       :default => false
      t.float       :cost ,         :default => 0.0
      t.float       :weight ,       :default => 0.1
      t.string      :ean,           :default => ""
      t.float       :tax,           :default => 0.0
      t.integer     :inventory ,    :default => 0
      t.string      :properties,    :default => ""
      t.string      :scode,         :default => ""
      t.date        :deleted_on
      t.references  :product,        index: true
      t.references  :category,       index: true
      t.references  :supplier,       index: true
      t.timestamps
    end
  end
end
