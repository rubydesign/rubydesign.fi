module ApplicationHelper
  include FoundationRailsHelper::FlashHelper

  def euros price
    price ? number_to_currency(price , :precision => 2 , :unit => "€") : 0.0
  end

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  # change the default link renderer for will_paginate and add global options
  def paginate(collection , options = {})
    #options = options.merge defaults
    options[:renderer] = FoundationPagination::Rails
    will_paginate collection, options
  end

end
