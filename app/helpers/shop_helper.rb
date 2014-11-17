module ShopHelper
  def parents(group)
    parents = []
    group = group.category
    while group
      parents << group
      group = group.category
    end
    parents.reverse
  end
  def in_group( product , get = 4)
    group = product.category
    return [] unless group
    prods = group.shop_products.to_a
    prods.delete(product)
    prods.sample(get)
  end

  # a short version of a desciption text. now we use markdown and often have a bold "header"
  # so if we find a bold we use just that, regardless of length given
  # otherwise we try and find a space close to the given length, to avoid ugly half-words
  def short text , len = 110
    ind = text.index( "**" , 10)  || text.index( "**" , 10)
    return text[0 .. ind + 1] if ind
    ind = text.index(" " , len - 10)
    ind ? text[0 .. ind + 1] : text[0 .. len +1]
  end
end
