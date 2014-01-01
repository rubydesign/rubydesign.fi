# encoding : utf-8
class ProductsController < BeautifulController

  before_filter :load_product, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    do_sort_and_paginate(:product)
    
    @q = Product.search(
      params[:q]
    )

    @product_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @product_scope_for_scope = @product_scope.dup
    
    unless params[:scope].blank?
      @product_scope = @product_scope.send(params[:scope])
    end
    
    @products = @product_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @product_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Product.attribute_names
          @product_scope.to_a.each{ |o|
            csv << Product.attribute_names.map{ |a| o[a] }
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
      format.json { render :json => @product }
    end
  end

  def new
    @product = Product.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @product }
    end
  end

  def edit
    
  end

  def create
    @product = Product.create(params_for_model)

    respond_to do |format|
      if @product.save
        format.html {
          redirect_to product_path(@product), :flash => { :notice => t(:create_success, :model => "product") }
        }
        format.json { render :json => @product, :status => :created, :location => @product }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update_attributes(params_for_model)
        format.html { redirect_to product_path(@product), :flash => { :notice => t(:update_success, :model => "product") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def delete
    @product.deleted_at = Time.now
    if @product.save
      redirect_to products_url , :flash => {:notice => "deleted"}
    else
      redirect_to products_url , :flash => {:notice => "error"}
    end      
  end
  
  private 
  
  def load_product
    @product = Product.find(params[:id])
  end

  def params_for_model
    params.require(:product).permit(:price,:cost,:weight,:name,:description,:link,:ean,:tax,:properties,:scode,:product_id,:product_group_id,:supplier_id, :main_picture,:extra_picture
)
  end
end

