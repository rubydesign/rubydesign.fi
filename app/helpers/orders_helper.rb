# encoding : utf-8
module OrdersHelper
  def mail_actions
    conf = OfficeClerk.config(:mail_buttons)
    return "" if conf.blank?
    conf.split(" ").collect{|s| s.strip }
  end
  def mail_path action

  end
  def number_with_comma n
    number_with_precision(n , :precision => 2 , :separator => "," , :strip_insignificant_zeros => false)
  end
  def print_styles
    OfficeClerk.config(:print_styles).split
  end
  def print_path style
    eval("office.#{style}_order_path(@order)")
  end

end
