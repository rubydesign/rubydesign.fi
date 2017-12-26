collection @products
attributes :id , :name , :inventory, :stock_level, :cost ,
           :scode , :position , :pack_unit
node :stock_diff do |product|
  product.inventory - product.stock_level
end
node :ordered do |product|
  @ordered_products[product.id]
end
node :category do |product|
  product.category ? product.category.name : "none"
end
