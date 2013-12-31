class ProductGroups < ActiveRecord::Migration
  def change
    create_table :product_groups do |t|
      t.references :product_group
      t.string      :name
      t.integer     :position
      t.string      :url_name
      t.attachment  :main_picture
      t.attachment  :extra_picture

      t.timestamps
    end
  end
end
