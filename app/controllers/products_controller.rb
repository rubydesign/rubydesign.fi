# encoding : utf-8
class ProductsController < AdminController

  before_filter :load_product, :only => [:show, :edit, :update, :delete]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    do_sort_and_paginate(:product)
    param = params[:q] || {}
    param.merge!(:product_id_null => 1) unless params[:basket]
    @q = Product.search( param )
    @product_scope = @q.result(:distinct => true)
    @product_scope_for_scope = @product_scope.dup
    unless params[:scope].blank?
      @product_scope = @product_scope.send(params[:scope])
    end
    @products = @product_scope.paginate( :page => params[:page], :per_page => 20 ).to_a
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
    
  end

  def create
    @product = Product.create(params_for_model)
    if @product.save
      redirect_to product_path(@product), :flash => { :notice => t(:create_success, :model => "product") }
    else
      render :action => "new"
    end
  end

  def update
    if @product.update_attributes(params_for_model)
      redirect_to product_path(@product), :flash => { :notice => t(:update_success, :model => "product") }
    else
      render :action => "edit"
    end
  end

  def delete
    @product.deleted_on = Time.now
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
    params.require(:product).permit(:price,:cost,:weight,:name,:description, :online,
      :link,:ean,:tax,:properties,:scode,:product_id,:category_id,:supplier_id, :main_picture,:extra_picture
)
  end
end

