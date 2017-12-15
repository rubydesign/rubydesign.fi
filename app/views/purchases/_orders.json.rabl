collection @orders
attributes :id , :created_at
node :name do |order|
  order.address[:name]
end
node :quantity do |order|
  order.basket.items.length
end
