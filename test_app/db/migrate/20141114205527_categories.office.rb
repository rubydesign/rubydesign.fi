class Categories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references  :category
      t.boolean     :online, :default => false
      t.string      :name
      t.text        :description
      t.text        :summary
      t.integer     :position , :default => 1
      t.string      :link
      t.attachment  :main_picture
      t.attachment  :extra_picture

      t.timestamps null: false
    end
    add_index :categories, :link,                :unique => true

  end
end
