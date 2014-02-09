class ShopController < ApplicationController
  before_action :load

  layout "shop"

  def product
    @product = Product.online.where(:link => params[:link]).first
    redirect_to :action => :group unless @product
    #error handling
#    @group = Category.find(@product.category_id)
  end

  def group
    @group = Category.online.where(:link => params[:link]).first 
    if @group and @group.categories.empty?
      @products = @group.products.no_items.online
      template = "product_list"
    else
      if @group
        @groups = @group.categories.online
        template = "sub_group"
      else
        @groups = Category.online.where( :category_id => nil )
        template = "main_group"
      end
    end
    render template
  end

  def page
    @products = Product.online.limit(50)
    template = params[:id]
    template = "tuotteista" if template.blank?
    @products = Product.online.limit(20)
    render template
  end
  private
    def load
      @menu =  {"/page/kotisivu" => "KOTISIVU" ,
                "/group/start" => "VERKKOKAUPPA" ,
                "/page/tuotteista" => "TUOTTEISTA",
                "/page/toimitusehdot" => "TOIMITUSEHDOT" ,
                "/page/liike" => "LIIKKEEMME" }
    end
end
