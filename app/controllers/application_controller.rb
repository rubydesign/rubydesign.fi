class ApplicationController < ActionController::Base

  helper ApplicationHelper
  include ApplicationHelper

  def error
    logger.info "Error" + request.url
    redirect_to "/"
  end


end
