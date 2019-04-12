class OfficeController < ActionController::Base

  helper OfficeHelper
  include OfficeHelper

  def error
    logger.info "Error" + request.url
    redirect_to "/"
  end


end
