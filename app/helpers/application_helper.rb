# -*- coding: utf-8 -*-
module ApplicationHelper
  
  def euros price
    price ? number_to_currency(price , :precision => 2 , :unit => "€") : 0.0
  end

  # change the default link renderer for will_paginate and add global options
  def paginate(collection , options = {})
    #options = options.merge defaults
    options[:renderer] = BootstrapPagination::Rails
    will_paginate collection, options
  end

end
