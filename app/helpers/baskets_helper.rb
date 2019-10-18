# encoding : utf-8
require "admin_helper"
module BasketsHelper
  def has_receipt?
    styles = RubyClerks.config(:print_styles)
    return false if styles.nil?
    return styles.split.include?("receipt")
  end
  def basket_edit_link basket , options = {}
    return "---" unless basket
    if basket.locked?
      text =  I18n.t(:locked) + ": "
      case basket.kori
      when Order
        text += I18n.t(:order)
        link = order_path(basket.kori)
      when Purchase
        text += I18n.t(:purchase)
        link = purchase_path(basket.kori)
      else
        raise "System Error: Locked basket without order #{basket.id}"
      end
    else
      if basket.kori
        key = basket.kori.class.name.downcase
        text = I18n.t(key)
      else
        text = t(:basket)
      end
      if(basket.kind)
        text = t(:house)
        link = edit_house_path(basket)
      else
        link = edit_basket_path(basket)
      end
    end
    return link_to text , link , options
  end
end
