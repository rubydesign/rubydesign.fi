class ShopController < ApplicationController
  before_action :load

  layout "shop"

  
  def product
    @product = Product.where(:link => params[:id]).first
    redirect_to :action => :group unless @product
    #error handling
#    @group = Category.find(@product.category_id)
  end

  def group
    @group = Category.where(:link => params[:id]).first
    @group = Category.first unless @group
    @products = @group.products
  end

  def page
    @products = Product.all.limit(50)
    template = params[:id]
    render template
  end
  private
    def load
      @groups = Category.where( :category_id => nil )
      @menu =  {"/page/kotisivu" => "KOTISIVU" ,
                "/group/start" => "VERKKOKAUPPA" ,
                "/page/tuotteista" => "TUOTTEISTA",
                "/page/toimitusehdot" => "TOIMITUSEHDOT" ,
                "/page/liike" => "LIIKKEEMME" }
    end
end
