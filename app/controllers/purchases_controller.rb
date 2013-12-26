# encoding : utf-8
class PurchasesController < BeautifulController

  before_filter :load_purchase, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:purchase] ||= (Purchase.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:purchase)
    do_sort_and_paginate(:purchase)
    
    @q = Purchase.search(
      params[:q]
    )

    @purchase_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @purchase_scope_for_scope = @purchase_scope.dup
    
    unless params[:scope].blank?
      @purchase_scope = @purchase_scope.send(params[:scope])
    end
    
    @purchases = @purchase_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @purchase_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Purchase.attribute_names
          @purchase_scope.to_a.each{ |o|
            csv << Purchase.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @purchase_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(Purchase,@purchase_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @purchase }
    end
  end

  def new
    @purchase = Purchase.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @purchase }
    end
  end

  def edit
    
  end

  def create
    @purchase = Purchase.create(params_for_model)

    respond_to do |format|
      if @purchase.save
        format.html {
          redirect_to purchase_path(@purchase), :flash => { :notice => t(:create_success, :model => "purchase") }
        }
        format.json { render :json => @purchase, :status => :created, :location => @purchase }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @purchase.update_attributes(params_for_model)
        format.html { redirect_to purchase_path(@purchase), :flash => { :notice => t(:update_success, :model => "purchase") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @purchases = []    
    
    Purchase.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:purchase)

        @purchases = Purchase.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @purchases = Purchase.find(params[:ids].to_a)
      end

      @purchases.each{ |purchase|
        if not Purchase.columns_hash[attr_or_method].nil? and
               Purchase.columns_hash[attr_or_method].type == :boolean then
         purchase.update_attribute(attr_or_method, boolean(value))
         purchase.save
        else
          case attr_or_method
          # Set here your own batch processing
          # purchase.save
          when "destroy" then
            purchase.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = Purchase
    foreignkey = :purchase_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_purchase
    @purchase = Purchase.find(params[:id])
  end

  def params_for_model
    params.require(:purchase).permit(Purchase.permitted_attributes)
  end
end

