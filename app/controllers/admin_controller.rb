# encoding : utf-8
class AdminController < ApplicationController

  before_filter :authenticate_user!

  layout "admin"

  before_filter :clean_search , :only => [:index , :search]

  def clean_search
    q = params[:q]
    return unless q
    q.keys.each do |key|
      q.delete(key) if q[key].blank?
    end
  end
end
