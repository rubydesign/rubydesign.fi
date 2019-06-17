class AddOrderNumberToOrder < ActiveRecord::Migration[5.2]
  def up
    add_column :orders, :order_number, :int
    Order.all.each do |order|
      next unless order.number
      new_num = order.number[1..9].to_i
      order.update_attribute(:order_number, new_num)
    end
  end
  def down
    remove_column :orders, :order_number, :int
  end
end
