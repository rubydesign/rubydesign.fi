collection @products
attributes :id , :name , :inventory, :stock_level, :cost
node :picture do |product|
  product.main_picture.url(:thumb)
end
node :stock_diff do |product|
  product.inventory - product.stock_level
end
