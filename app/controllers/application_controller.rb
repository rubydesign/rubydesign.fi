class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_clerk

  def current_clerk
    return @current_clerk if @current_clerk
    return nil unless session[:clerk_email]
    @current_clerk = Clerk.where( :email => session[:clerk_email] ).limit(1).first 
  end

  def error
    logger.info "Error" + request.url
    redirect_to "/"
  end

  private


end
