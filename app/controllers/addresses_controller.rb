# encoding : utf-8
class AddressesController < BeautifulController

  before_filter :load_address, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:address] ||= (Address.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:address)
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
      format.xml{ 
        render :xml => @address_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(Address,@address_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @address }
    end
  end

  def new
    @address = Address.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @address }
    end
  end

  def edit
    
  end

  def create
    @address = Address.create(params_for_model)

    respond_to do |format|
      if @address.save
        format.html {
          if params[:mass_inserting] then
            redirect_to addresses_path(:mass_inserting => true)
          else
            redirect_to address_path(@address), :flash => { :notice => t(:create_success, :model => "address") }
          end
        }
        format.json { render :json => @address, :status => :created, :location => @address }
      else
        format.html {
          if params[:mass_inserting] then
            redirect_to addresses_path(:mass_inserting => true), :flash => { :error => t(:error, "Error") }
          else
            render :action => "new"
          end
        }
        format.json { render :json => @address.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @address.update_attributes(params_for_model)
        format.html { redirect_to address_path(@address), :flash => { :notice => t(:update_success, :model => "address") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @address.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @address.destroy

    respond_to do |format|
      format.html { redirect_to addresses_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @addresses = []    
    
    Address.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:address)

        @addresses = Address.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @addresses = Address.find(params[:ids].to_a)
      end

      @addresses.each{ |address|
        if not Address.columns_hash[attr_or_method].nil? and
               Address.columns_hash[attr_or_method].type == :boolean then
         address.update_attribute(attr_or_method, boolean(value))
         address.save
        else
          case attr_or_method
          # Set here your own batch processing
          # address.save
          when "destroy" then
            address.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = Address
    foreignkey = :address_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_address
    @address = Address.find(params[:id])
  end

  def params_for_model
    params.require(:address).permit(Address.permitted_attributes)
  end
end

