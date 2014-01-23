# encoding : utf-8
module AdminHelper

  def column_style(model_name, field_name, display_default = 'table-cell', other_css = "")
    return :class => ""
  end
  def sorting_header(model_name, attribute_name, namespace)
    attribute_name
  end

end
