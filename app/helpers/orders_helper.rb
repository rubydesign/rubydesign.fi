# encoding : utf-8
require "admin_helper"
module OrdersHelper
  def print_styles
    OfficeClerk.config(:print_styles).split
  end
  def print_path style
    eval("#{style}_order_path(@order)")
  end
end
