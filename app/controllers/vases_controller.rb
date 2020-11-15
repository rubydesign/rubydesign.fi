class VasesController < ApplicationController

  # GET /vases
  def index
    @vases = [ :plain ]
  end

  # GET /vases/1
  def show
    @vase = params[:id]
  end

end
