collection @products
attributes :id , :name ,  :scode , :position , :pack_unit , :price , :summary , :description
node :category do |product|
  product.category ? product.category.name : "none"
end
node :amount do |product|
  product.amount_for(@basket) || 1
end
