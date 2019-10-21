collection @products
attributes :id , :name 
node :ean do |product|
  product.ean.blank? ? product.name : product.ean
end
