# encoding : utf-8
class BasketsController < BeautifulController

  before_filter :load_basket, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    do_sort_and_paginate(:basket)
    
    @q = Basket.search(
      params[:q]
    )

    @basket_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @basket_scope_for_scope = @basket_scope.dup
    
    unless params[:scope].blank?
      @basket_scope = @basket_scope.send(params[:scope])
    end
    
    @baskets = @basket_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

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
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @basket }
    end
  end

  def new
    @basket = Basket.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @basket }
    end
  end

  def edit
    
  end

  def create
    @basket = Basket.create(params_for_model)

    respond_to do |format|
      if @basket.save
        format.html {
          redirect_to basket_path(@basket), :flash => { :notice => t(:create_success, :model => "basket") }
        }
        format.json { render :json => @basket, :status => :created, :location => @basket }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @basket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @basket.update_attributes(params_for_model)
        format.html { redirect_to basket_path(@basket), :flash => { :notice => t(:update_success, :model => "basket") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @basket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @basket.destroy

    respond_to do |format|
      format.html { redirect_to baskets_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @baskets = []    
    
    Basket.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:basket)

        @baskets = Basket.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @baskets = Basket.find(params[:ids].to_a)
      end

      @baskets.each{ |basket|
        if not Basket.columns_hash[attr_or_method].nil? and
               Basket.columns_hash[attr_or_method].type == :boolean then
         basket.update_attribute(attr_or_method, boolean(value))
         basket.save
        else
          case attr_or_method
          # Set here your own batch processing
          # basket.save
          when "destroy" then
            basket.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  private 
  
  def load_basket
    @basket = Basket.find(params[:id])
  end

  def params_for_model
    params.require(:basket).permit(:name , :item_attributes)
  end
end

