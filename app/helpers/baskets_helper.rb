# encoding : utf-8
require "admin_helper"
module BasketsHelper
  def has_receipt?
    styles = OfficeClerk.config(:print_styles)
    return false if styles.nil?
    return styles.split.include?("receipt")
  end
  def basket_edit_link basket , options = {}
    return "---" unless basket
    return "" unless request.url.include?("basket")
    if basket.locked?
      text =  I18n.t(:locked) + ": "
      case basket.kori
      when Order
        text += I18n.t(:order)
        link = order_path(basket.kori) rescue ""
      when Purchase
        text += I18n.t(:purchase)
        link = purchase_path(basket.kori) rescue ""
      else
        raise "System Error: Locked basket without order #{basket.id}"
      end
    else
      text = t(:basket)
      link = edit_basket_path(basket)
    end
    return link_to text , link , options 
  end
end
