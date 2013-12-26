class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.name :string

      t.timestamps
    end
  end
end
