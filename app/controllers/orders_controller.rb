# encoding : utf-8
class OrdersController < BeautifulController

  before_filter :load_order, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    do_sort_and_paginate(:order)
    
    @q = Order.search(
      params[:q]
    )

    @order_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @order_scope_for_scope = @order_scope.dup
    
    unless params[:scope].blank?
      @order_scope = @order_scope.send(params[:scope])
    end
    
    @orders = @order_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @order_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Order.attribute_names
          @order_scope.to_a.each{ |o|
            csv << Order.attribute_names.map{ |a| o[a] }
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
      format.json { render :json => @order }
    end
  end

  def new
    @order = Order.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @order }
    end
  end

  def edit
    
  end

  def create
    @order = Order.create(params_for_model)

    respond_to do |format|
      if @order.save
        format.html {
          redirect_to order_path(@order), :flash => { :notice => t(:create_success, :model => "order") }
        }
        format.json { render :json => @order, :status => :created, :location => @order }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @order.update_attributes(params_for_model)
        format.html { redirect_to order_path(@order), :flash => { :notice => t(:update_success, :model => "order") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :ok }
    end
  end

  private 
  
  def load_order
    @order = Order.find(params[:id])
  end

  def params_for_model
    params.require(:order).permit(Order.permitted_attributes)
  end
end

