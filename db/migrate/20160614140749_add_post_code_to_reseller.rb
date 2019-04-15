class AddPostCodeToReseller < ActiveRecord::Migration[4.2]
  def change
    add_column :resellers, :post_code, :string
  end
end
