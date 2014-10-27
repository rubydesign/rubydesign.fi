module ShopHelper
  def parents(group)
    parents = []
    while group
      parents << group
      group = group.category
    end
    parents.reverse
  end
  def in_group( product , get = 4)
    group = product.category
    return [] unless group
    prods = group.products.online.to_a
    prods.delete(product)
    prods.sample(get)
  end
end
