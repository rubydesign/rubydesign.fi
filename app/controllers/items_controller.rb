# encoding : utf-8
class ItemsController < BeautifulController

  before_filter :load_item, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:item] ||= (Item.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:item)
    do_sort_and_paginate(:item)
    
    @q = Item.search(
      params[:q]
    )

    @item_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @item_scope_for_scope = @item_scope.dup
    
    unless params[:scope].blank?
      @item_scope = @item_scope.send(params[:scope])
    end
    
    @items = @item_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @item_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Item.attribute_names
          @item_scope.to_a.each{ |o|
            csv << Item.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @item_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(Item,@item_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @item }
    end
  end

  def new
    @item = Item.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @item }
    end
  end

  def edit
    
  end

  def create
    @item = Item.create(params_for_model)

    respond_to do |format|
      if @item.save
        format.html {
          redirect_to item_path(@item), :flash => { :notice => t(:create_success, :model => "item") }
        }
        format.json { render :json => @item, :status => :created, :location => @item }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @item.update_attributes(params_for_model)
        format.html { redirect_to item_path(@item), :flash => { :notice => t(:update_success, :model => "item") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @items = []    
    
    Item.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:item)

        @items = Item.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @items = Item.find(params[:ids].to_a)
      end

      @items.each{ |item|
        if not Item.columns_hash[attr_or_method].nil? and
               Item.columns_hash[attr_or_method].type == :boolean then
         item.update_attribute(attr_or_method, boolean(value))
         item.save
        else
          case attr_or_method
          # Set here your own batch processing
          # item.save
          when "destroy" then
            item.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = Item
    foreignkey = :item_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_item
    @item = Item.find(params[:id])
  end

  def params_for_model
    params.require(:item).permit(Item.permitted_attributes)
  end
end

