object @purchase.basket
attribute :id , :total_price
child :items , :object_root => false do
  attributes :id , :name , :quantity , :price , :product_id
  node :scode do |item|
    item.product.scode
  end
end
