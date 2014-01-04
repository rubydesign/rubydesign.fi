# encoding : utf-8
class BasketsController < BeautifulController

  before_filter :load_basket, :only => [:show, :edit, :update, :destroy , :find]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    do_sort_and_paginate(:basket)
    @q = Basket.search( params[:q])
    @basket_scope = @q.result( :distinct => true ).sorting( params[:sorting])
    @basket_scope_for_scope = @basket_scope.dup
    unless params[:scope].blank?
      @basket_scope = @basket_scope.send(params[:scope])
    end
    @baskets = @basket_scope.paginate( :page => params[:page], :per_page => 20 ).to_a
    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @basket_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Basket.attribute_names
          @basket_scope.to_a.each{ |o|
            csv << Basket.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
    end
  end

  def show
  end

  def new
    @basket = Basket.create! :name => "cart"
    render "show"
  end

  def edit
    ean = params[:ean]
    prod = Product.find_by_ean ean
    if(prod)
      @basket.add_product prod
      redirect_to :action => :show
    else
      session[:search] ||= {}
      session[:search][:product] =  {"name_cont"=> ean}
      session[:basket] = true
      redirect_to :action => :index , :controller => :products
    end
  end
  
  def create
    @basket = Basket.create(params_for_basket)
    if @basket.save
      redirect_to basket_path(@basket), :flash => { :notice => t(:create_success, :model => "basket") }
    else
      render :action => "new"
    end
  end

  def update
    if @basket.update_attributes(params_for_basket)
      redirect_to basket_path(@basket), :flash => { :notice => t(:update_success, :model => "basket") }
    else
      render :action => "show" 
    end
  end

  def destroy
    @basket.destroy
    redirect_to baskets_url 
  end

  private 
  
  def load_basket
    @basket = Basket.find(params[:id])
  end

  def params_for_basket
    params.require(:basket).permit(:name , :items_attributes => [:quantity , :price , :id] )
  end
end

