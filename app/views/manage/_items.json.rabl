collection @items
attributes :id , :name , :quantity , :price , :product_id
node :scode do |item|
  item.product.scode
end
node :kind do |item|
  item.basket.kori_type
end
node :created_at do |item|
  item.created_at.to_i * 1000
end
