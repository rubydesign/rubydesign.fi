class KolmeDController < ApplicationController

  def show
    set_template
    render( template: @template)
  end
  private
  def set_template
    return lamp if [].include?(params[:id])
    @template = "kolme_d/#{params[:id]}"
  end
end
