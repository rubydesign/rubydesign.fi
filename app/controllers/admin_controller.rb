# encoding : utf-8
class AdminController < OfficeController

  layout "office_clerk"

  before_filter :clean_search , :only => [:index , :search]

  before_filter :require_admin
  
  def require_admin
    clerk = current_clerk
    return if clerk and clerk.admin
    redirect_to sign_in
  end

  def sign_in
    has_ssl? ? sign_in_path(:protocol => :https) : sign_in_url
  end

  def clean_search
    q = params[:q]
    return unless q
    q.keys.each do |key|
      q.delete(key) if q[key].blank?
    end
  end
end
