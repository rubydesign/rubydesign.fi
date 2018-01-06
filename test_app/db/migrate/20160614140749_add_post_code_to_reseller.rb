class AddPostCodeToReseller < ActiveRecord::Migration
  def change
    add_column :resellers, :post_code, :string
  end
end
