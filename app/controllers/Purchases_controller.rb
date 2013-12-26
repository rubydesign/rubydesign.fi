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

    @Purchase_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @Purchase_scope_for_scope = @Purchase_scope.dup
    
    unless params[:scope].blank?
      @Purchase_scope = @Purchase_scope.send(params[:scope])
    end
    
    @Purchases = @Purchase_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @Purchase_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Purchase.attribute_names
          @Purchase_scope.to_a.each{ |o|
            csv << Purchase.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @Purchase_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(Purchase,@Purchase_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @Purchase }
    end
  end

  def new
    @Purchase = Purchase.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @Purchase }
    end
  end

  def edit
    
  end

  def create
    @Purchase = Purchase.create(params_for_model)

    respond_to do |format|
      if @Purchase.save
        format.html {
          if params[:mass_inserting] then
            redirect_to purchases_path(:mass_inserting => true)
          else
            redirect_to Purchase_path(@Purchase), :flash => { :notice => t(:create_success, :model => "purchasease") }
          end
        }
        format.json { render :json => @Purchase, :status => :created, :location => @Purchase }
      else
        format.html {
          if params[:mass_inserting] then
            redirect_to purchases_path(:mass_inserting => true), :flash => { :error => t(:error, "Error") }
          else
            render :action => "new"
          end
        }
        format.json { render :json => @Purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @Purchase.update_attributes(params_for_model)
        format.html { redirect_to Purchase_path(@Purchase), :flash => { :notice => t(:update_success, :model => "purchasease") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @Purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @Purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @Purchases = []    
    
    Purchase.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:purchase)

        @Purchases = Purchase.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @Purchases = Purchase.find(params[:ids].to_a)
      end

      @Purchases.each{ |Purchase|
        if not Purchase.columns_hash[attr_or_method].nil? and
               Purchase.columns_hash[attr_or_method].type == :boolean then
         Purchase.update_attribute(attr_or_method, boolean(value))
         Purchase.save
        else
          case attr_or_method
          # Set here your own batch processing
          # Purchase.save
          when "destroy" then
            Purchase.destroy
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
    @Purchase = Purchase.find(params[:id])
  end

  def params_for_model
    params.require(:purchase).permit(Purchase.permitted_attributes)
  end
end

