class OfficeController < ApplicationController

  helper OfficeHelper
  include OfficeHelper

  include OfficeClerk::Engine.routes.url_helpers

  def redirect_after_sign_up
    redirect_to main_app.root_url, :notice => t(:signed_up)
  end
  def redirect_after_sign_in
    redirect_to main_app.root_url, :notice => t(:signed_in)
  end

  def error
    logger.info "Error" + request.url
    redirect_to "/"
  end


end
