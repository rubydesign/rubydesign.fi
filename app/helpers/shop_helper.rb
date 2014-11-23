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
  # so one can give a char sequence
  def short text , chop = "**"
    ind = text.index( chop , 10)
    if ind
      return text[0 .. ind + 1] 
    else
      return text[0 .. 100] 
    end
  end
end
