# encoding : utf-8
require "admin_helper"
module CategoriesHelper

  def parents(group)
    parents = []
    group = group.category
    while group
      parents << group
      group = group.category
    end
    parents.reverse
  end
  def group_path group
    category_path(group)
  end

end
