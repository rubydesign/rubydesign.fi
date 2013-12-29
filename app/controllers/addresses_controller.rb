# encoding : utf-8
class AddressesController < BeautifulController

  before_filter :load_address, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    do_sort_and_paginate(:address)
    
    @q = Address.search(
      params[:q]
    )

    @address_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @address_scope_for_scope = @address_scope.dup
    
    unless params[:scope].blank?
      @address_scope = @address_scope.send(params[:scope])
    end
    
    @addresses = @address_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @address_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Address.attribute_names
          @address_scope.to_a.each{ |o|
            csv << Address.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
    end
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id]).dup || Address.new
    render "new" , :flash => { :notice => "create a new addresses" }
  end

  def create
    @address = Address.create(params_for_model)
    if @address.save
        redirect_to address_path(@address), :flash => { :notice => t(:create_success, :model => "address") }
    else
        render :action => "new"
    end
  end

  def update
    if @address.update_attributes(params_for_model)
      redirect_to address_path(@address), :flash => { :notice => t(:update_success, :model => "address") }
    else
      render :action => "edit" 
    end
  end

  def destroy
    redirect_to address_path, :flash => { :notice => "cant destroy addresses" }
  end

  private 
  
  def load_address
    @address = Address.find(params[:id])
  end

  def params_for_model
    params.require(:address).permit(Address.permitted_attributes)
  end
end

