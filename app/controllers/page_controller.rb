class PageController < ApplicationController

  def index
    @page =  params[:page] || "index"
    response.headers['Content-type'] = 'text/html; charset=utf-8'
    if template_exists? @page
      render :template =>  @page
    else
      if template_exists?("static/#{@page}")
        render :template => "static/#{@page}"
      else
        render :template =>  "page/three"
      end
    end
  end

  def error_404
    render status: 404 , :plain => "move along"
  end

end
