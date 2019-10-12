# This migration comes from office (originally 20171224204344)
class AddPositionToProduct < ActiveRecord::Migration[4.2][5.0]
  def change
    add_column     :products, :position, :int , default: 1

    # remove_column  :products, :extra_picture_file_size, :int
    # remove_column  :products, :extra_picture_file_name, :string
    # remove_column  :products, :extra_picture_content_type, :string
    # remove_column  :products, :extra_picture_updated_at, :datetime
    #
    # remove_column  :categories, :extra_picture_file_size, :int
    # remove_column  :categories, :extra_picture_file_name, :string
    # remove_column  :categories, :extra_picture_content_type, :string
    # remove_column  :categories, :extra_picture_updated_at, :datetime

  end
end
