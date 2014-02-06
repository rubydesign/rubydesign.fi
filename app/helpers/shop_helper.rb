module ShopHelper
  def parents(group)
    parents = []
    while group
      parents << group
      group = group.category
    end
    parents.reverse
  end
end
