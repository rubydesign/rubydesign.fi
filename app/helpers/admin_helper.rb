# encoding : utf-8
module AdminHelper

  def basket_edit_link basket , options = {}
    return "---" unless basket
    text = t(:edit)
    link= basket_path(basket)
    case basket.kori_type
    when "Order"
      text = I18n.t(:order)
      link = order_path(basket.kori)
    when "Purchase"
      text = I18n.t(:purchase)
      link = purchase_path(basket.kori)
    end
    return link_to text , link , options 
  end
  
  def sorting_header(model_name, attribute_name, namespace)
    attribute_name
  end

end
