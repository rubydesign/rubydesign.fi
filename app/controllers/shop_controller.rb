class ShopController < ApplicationController
  before_action :load

  layout "shop"

  
  def product
    @product = Product.where(:link => params[:id]).first
    #error handling
#    @group = Category.find(@product.category_id)
  end

  def group
    @group = Category.where(:link => params[:id])
    @group = Category.first unless @group
  end

  def page
    template = params[:id]
    render template
  end
  private
    def load
      @groups = Category.all
      @menu =  {"/page/kotisivu" => "KOTISIVU" ,
                "/group/start" => "VERKKOKAUPPA" ,
                "/page/tuotteista" => "TUOTTEISTA",
                "/page/toimitusehdot" => "TOIMITUSEHDOT" ,
                "/page/liike" => "LIIKKEEMME" }
    end
end
