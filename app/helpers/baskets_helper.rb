# encoding : utf-8
require "admin_helper"
module BasketsHelper
  def has_receipt?
    styles = OfficeClerk.config(:print_styles)
    return false if styles.nil?
    return styles.split.include?("receipt")
  end
end
