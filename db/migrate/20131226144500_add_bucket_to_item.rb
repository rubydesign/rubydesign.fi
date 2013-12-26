class AddBucketToItem < ActiveRecord::Migration
  def change
    add_column :items, :bucket_id, :integer
    add_index :items, :bucket_id
  end
end
