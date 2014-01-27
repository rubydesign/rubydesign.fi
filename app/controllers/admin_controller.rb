# encoding : utf-8
class AdminController < ApplicationController

  layout "admin"

  before_filter :clean_search , :only => [:index , :search]

  before_filter :require_admin
  
  def require_admin
    user = current_user
    return if user and user.admin
    redirect_to root_url
  end
  
  def clean_search
    q = params[:q]
    return unless q
    q.keys.each do |key|
      q.delete(key) if q[key].blank?
    end
  end
end
