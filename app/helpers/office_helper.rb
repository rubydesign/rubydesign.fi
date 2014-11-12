# -*- coding: utf-8 -*-
module ApplicationHelper
  
  def markdown text
    return "" if text.blank?
    return sanitize Kramdown::Document.new(text).to_html
  end

  def euros price
    price ? number_to_currency(price , :precision => 2 , :unit => "€") : 0.0
  end

  def date d
    return "" unless d
    I18n.l d
  end

  # change the default link renderer for will_paginate and add global options
  def paginate(collection , options = {})
    #options = options.merge defaults
    options[:renderer] = BootstrapPagination::Rails
    will_paginate collection, options
  end

end
