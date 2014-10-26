class ShopController < ApplicationController
  before_action :load

  layout "shop"

  def welcome
    @groups = Category.online.where( :category_id => nil )
    render :layout => false
  end

  def product
    @product = Product.online.where(:link => params[:link]).first
    redirect_to :action => :group unless @product
    @group = @product.category
    #error handling
#    @group = Category.find(@product.category_id)
  end

  def add
    prod = Product.find( params[:id]) # no id will raise which in turn will show home page
    current_basket.add_product(prod)
    redirect_to shop_group_path(prod.category.link), :flash => { :notice => t(:product_added) }
  end

  def group
    @group = Category.online.where(:link => params[:link]).first 
    if @group
      @products = @group.products.no_items.online
      template = "product_list"
      @groups = @group.categories.online
    else
      @groups = Category.online.where( :category_id => nil )
      template = "main_group"
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
