object @basket
attribute :id , :total_price , :info
child :items , :object_root => false do
  attributes :id , :name , :quantity , :price , :product_id
  node :scode do |item|
    item.product.scode
  end
  node :position do |item|
    item.product.position
  end
  node :description do |item|
    item.product.description
  end
  node :category do |item|
    item.product.category.name
  end
  node :pack_unit do |item|
    item.product.pack_unit
  end
end
