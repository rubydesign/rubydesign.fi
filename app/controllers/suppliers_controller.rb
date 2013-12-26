# encoding : utf-8
class SuppliersController < BeautifulController

  before_filter :load_supplier, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:supplier] ||= (Supplier.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:supplier)
    do_sort_and_paginate(:supplier)
    
    @q = Supplier.search(
      params[:q]
    )

    @supplier_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @supplier_scope_for_scope = @supplier_scope.dup
    
    unless params[:scope].blank?
      @supplier_scope = @supplier_scope.send(params[:scope])
    end
    
    @suppliers = @supplier_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @supplier_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Supplier.attribute_names
          @supplier_scope.to_a.each{ |o|
            csv << Supplier.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @supplier_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(Supplier,@supplier_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @supplier }
    end
  end

  def new
    @supplier = Supplier.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @supplier }
    end
  end

  def edit
    
  end

  def create
    @supplier = Supplier.create(params_for_model)

    respond_to do |format|
      if @supplier.save
        format.html {
          redirect_to supplier_path(@supplier), :flash => { :notice => t(:create_success, :model => "supplier") }
        }
        format.json { render :json => @supplier, :status => :created, :location => @supplier }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @supplier.update_attributes(params_for_model)
        format.html { redirect_to supplier_path(@supplier), :flash => { :notice => t(:update_success, :model => "supplier") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @supplier.destroy

    respond_to do |format|
      format.html { redirect_to suppliers_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @suppliers = []    
    
    Supplier.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:supplier)

        @suppliers = Supplier.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @suppliers = Supplier.find(params[:ids].to_a)
      end

      @suppliers.each{ |supplier|
        if not Supplier.columns_hash[attr_or_method].nil? and
               Supplier.columns_hash[attr_or_method].type == :boolean then
         supplier.update_attribute(attr_or_method, boolean(value))
         supplier.save
        else
          case attr_or_method
          # Set here your own batch processing
          # supplier.save
          when "destroy" then
            supplier.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = Supplier
    foreignkey = :supplier_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_supplier
    @supplier = Supplier.find(params[:id])
  end

  def params_for_model
    params.require(:supplier).permit(Supplier.permitted_attributes)
  end
end

