object @purchase.basket
attribute :id , :total_price
child :items , :object_root => false do
  attributes :id , :name , :quantity , :price , :product_id
  node :picture do |item|
    item.product.main_picture.url(:thumb)
  end
end
