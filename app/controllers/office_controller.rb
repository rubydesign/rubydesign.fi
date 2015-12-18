class OfficeController < ApplicationController

  helper OfficeHelper
  include OfficeHelper

  helper  OfficeClerk::Engine.routes.url_helpers
  include OfficeClerk::Engine.routes.url_helpers

  def error
    logger.info "Error" + request.url
    redirect_to "/"
  end


end
