object @purchase.basket
attribute :id
child :items , :object_root => false do
  attributes :id , :quantity
  node :scode do |item|
    item.product.scode
  end
  node :name do |item|
    item.product.name
  end
end
