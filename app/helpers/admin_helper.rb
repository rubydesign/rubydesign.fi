# encoding : utf-8
module AdminHelper

  def basket_edit_link basket , options = {}
    return "---" unless basket
    return "" unless request.url.include?("basket")
    text = t(:edit) + " "
    link = edit_basket_path(basket)
    case basket.kori_type
    when "Order"
      text += I18n.t(:order)
      link = order_path(basket.kori) rescue ""
    when "Purchase"
      text += I18n.t(:purchase)
      link = purchase_path(basket.kori) rescue ""
    end
    return link_to text , link , options 
  end
  
  def sort_date key
    return "" unless params[:q]
    params[:q][key] || ""
  end
end
