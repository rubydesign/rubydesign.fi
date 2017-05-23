# encoding : utf-8
require "admin_helper"
module ProductsHelper

  # show inventory that is really available, ie has not been "reserved" by unshipped orders
  def available_inventory
    params[:in_orders]
  end
end
