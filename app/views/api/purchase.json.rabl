object @purchase.basket
attribute :id
child :items , :object_root => false do
  attributes :price
  node :scode do |item|
    item.product.scode
  end
end
