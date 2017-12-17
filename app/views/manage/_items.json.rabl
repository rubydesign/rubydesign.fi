collection @items
attributes :id , :name , :quantity , :price , :product_id
node :scode do |item|
  item.product.scode
end
