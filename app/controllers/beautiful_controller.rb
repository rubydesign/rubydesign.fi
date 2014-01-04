# encoding : utf-8
class BeautifulController < ApplicationController
  
  layout "beautiful_layout"

  def dashboard
  end

  def do_sort_and_paginate(model_sym)
    # Sort
    session[:sorting] ||= {}
    session[:sorting][model_sym] ||= { :attribute => "id", :sorting => "DESC" }
    params[:sorting] ||= session[:sorting][model_sym]
    session[:sorting][model_sym] = params[:sorting]
    
    # Search and Filter
    session[:search] ||= {}
    params[:page] = 1 if not params[:q].nil?
    params[:q] ||= session[:search][model_sym]
    session[:search][model_sym] = params[:q] if params[:skip_save_search].blank?
        
    # Scope
    session[:scope] ||= {}
    session[:scope][model_sym] ||= nil
    params[:page] = 1 if not params[:scope].nil?
    params[:scope] ||= session[:scope][model_sym]
    session[:scope][model_sym] = params[:scope]

    # Paginate
    session[:paginate] ||= {}
    session[:paginate][model_sym] ||= nil
    params[:page] ||= session[:paginate][model_sym]
    session[:paginate][model_sym] = params[:page]
  end
  
  def boolean(string)
    return true if string == true || string =~ (/(true|t|yes|y|1)$/i)
    return false if string == false || string.nil? || string =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{string}\"")
  end

end
