collection @products
attributes :id , :name ,  :scode , :position , :pack_unit , :price , :summary , :description
node :category do |product|
  product.category ? product.category.name : "none"
end
node :amount do |product|
  @basket.amount_for(product) || 1
end
