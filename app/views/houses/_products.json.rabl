house = @basket
collection @products
attributes :id , :name ,  :scode , :position , :pack_unit , :price , :summary
node :category do |product|
  product.category ? product.category.name : "none"
end
node :amount do |product|
  begin
    ret = eval(product.description).to_f
    ret < 1 ? 1   : ret
  rescue
    1
  end
end
