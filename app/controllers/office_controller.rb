class OfficeController < ApplicationController

  helper OfficeHelper
  include OfficeHelper

  include OfficeClerk::Engine.routes.url_helpers

  def error
    logger.info "Error" + request.url
    redirect_to "/"
  end


end
