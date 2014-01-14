# encoding : utf-8
module AdminHelper

  def column_style(model_name, field_name, display_default = 'table-cell', other_css = "")
    return :style => "display:table-cell;" + other_css
  end

  def sorting_header(model_name, attribute_name, namespace)
    attr    = nil
    sort    = nil

    if not params[:sorting].blank? then
      attr = params[:sorting][:attribute]
      sort = params[:sorting][:sorting]
    end

    attr    = attr.to_s.downcase
    sortstr = sort.to_s.downcase
    opposite_sortstr = ""
    csort = '' # <i class="icon-stop"></i>
    if attribute_name == attr then
      if sortstr == "asc" then
        csort = '<i class="icon-chevron-up"></i>'
        opposite_sortstr = "desc"
      elsif sortstr == "desc" then
        csort = '<i class="icon-chevron-down"></i>'
        opposite_sortstr = "asc"
      end
    else
      opposite_sortstr = "asc"
    end

    default_caption = attribute_name.capitalize
    if is_belongs_to_column?(default_caption) then
      default_caption = get_belongs_to_model(default_caption)
    end

    cap = i18n_translate_path(model_name, attribute_name)

    caption = t(cap, :default => default_caption).capitalize
    strpath = model_name.pluralize + "_url"
    strpath = namespace + '_' + strpath if not namespace.blank?

    return link_to(
        "#{csort} #{caption}".html_safe,
        eval(strpath) + "?" +
            CGI.unescape({:sorting => {:attribute => attribute_name.downcase,:sorting => opposite_sortstr}}.to_query)
    ).html_safe
  end

  def info_input(modname, attr)
    model_name = modname.to_sym
    rep = false
    if not session[:search].blank? and not session[:search][model_name].blank? then
      if attr.kind_of?(Array) then
        rep = (attr.any? { |elt| (not session[:search][model_name][elt].blank?) })
      else
        rep = (not session[:search][model_name][attr].blank?)
      end
    end
    return (rep ? "info" : "")
  end

  def exclude_richtext_field(array_of_attributes, only_fulltext = true)
    pattern = /$()_fulltext/
    richtext_attributes = []
    array_of_attributes.each{ |a|
      richtext_attributes << a[pattern] if a[pattern]
    }
    array_of_attributes.reject!{ |a| richtext_attributes.include?(a) or richtext_attributes.include?(a + "_typetext") }
    return array_of_attributes
  end

  def is_belongs_to_column?(column)
    return true if column[-3,3] == "_id"
  end

  def get_belongs_to_model(column)
    return column[0..-4]
  end

  def clean_params
    params.delete :q
    params.delete :fields
  end

  def i18n_translate_path(model, attr)
    "app.models.#{model}.bs_attributes.#{attr}"
  end

end
