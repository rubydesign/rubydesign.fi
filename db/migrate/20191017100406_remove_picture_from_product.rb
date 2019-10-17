class RemovePictureFromProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :main_picture_file_name, :string
    remove_column :products, :main_picture_content_type, :string
    remove_column :products, :main_picture_file_size, :integer
    remove_column :products, :main_picture_updated_at, :datetime
    remove_column :products , :product_id ,:integer
  end
end
