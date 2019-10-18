collection @products
attributes :id , :name , :inventory, :stock_level, :cost ,
           :scode , :position , :pack_unit
node :category do |product|
  product.category ? product.category.name : "none"
end
