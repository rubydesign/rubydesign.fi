collection @products
attributes :id , :name ,  :scode , :position , :pack_unit , :price , :desciption , :summary
node :category do |product|
  product.category ? product.category.name : "none"
end
