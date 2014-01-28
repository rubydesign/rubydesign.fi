class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def current_user
    return @current_user if @current_user
    return nil unless session[:user_email]
    @current_user = User.where( :email => session[:user_email] ).limit(1).first 
  end

end
