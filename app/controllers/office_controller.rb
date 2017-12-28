class OfficeController < ApplicationController

  helper OfficeHelper
  include OfficeHelper

  helper  RubyClerks::Engine.routes.url_helpers
  include RubyClerks::Engine.routes.url_helpers

  def error
    logger.info "Error" + request.url
    redirect_to "/"
  end


end
