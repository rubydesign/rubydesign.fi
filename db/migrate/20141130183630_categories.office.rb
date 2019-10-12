# This migration comes from office (originally 20131226143612)
class Categories < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.references  :category
      t.boolean     :online, :default => false
      t.string      :name
      t.text        :description
      t.text        :summary
      t.integer     :position , :default => 1
      t.string      :link
      t.string "main_picture_file_name", limit: 255
      t.string "main_picture_content_type", limit: 255
      t.integer "main_picture_file_size"
      t.datetime "main_picture_updated_at"

      t.timestamps
    end
    add_index :categories, :link,                :unique => true

  end
end
