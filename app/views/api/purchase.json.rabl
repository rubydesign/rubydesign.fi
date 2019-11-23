object @purchase.basket
attribute :id
child :items , :object_root => false do
  attributes :id , :quantity
  node :scode do |item|
    item.product.scode
  end
end
